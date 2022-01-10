//
//  NetworkService.swift
//  TestGithubProject
import Foundation
import RxSwift
import RxSwiftExt
import Moya
import Alamofire

class NetworkService {
    // MARK: - Moya Provider Setup
    
    private lazy var provider: MoyaProvider<GithubTarget> = {
        .init()
    }()
    
    init(with provider: MoyaProvider<GithubTarget>? = nil) {
        if let provider = provider {
            self.provider = provider
        }
    }
    
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return decoder
    }()
    
    static let shared: NetworkService = .init()
}
// MARK: - NetworkServiceProtocol Implementation
extension NetworkService: NetworkServiceProtocol {
    func searchRepositories(_ searchString: String) -> Single<[GithubRepository]> {
        return provider.rx
            .request(.searchRepositories(searchString))
            .remapStatusErrors()
            .map([GithubRepository].self, atKeyPath: "items", using: Self.jsonDecoder)
    }
    
    func getRepositoryDetails(_ ownerName: String, _ repoName: String) -> Single<GithubRepository> {
        return provider.rx
            .request(.getRepositoryDetails(ownerName, repoName))
            .remapStatusErrors()
            .map(GithubRepository.self, using: Self.jsonDecoder)
    }
    
    func getRepositoryReadme(_ ownerName: String, _ repoName: String) -> Single<String> {
        return provider.rx
            .request(.getRepositoryReadme(ownerName, repoName))
            .remapStatusErrors()
            .printContents()
            .mapString()
//            .printContents()
//            .mapString(atKeyPath: "content")
//            .map { (base64string: String) in
//                base64string.split(separator: "\n")
//                    .compactMap { subString in
//                        guard let base64decodedData = Data(base64Encoded: String(subString)),
//                              let decodedString = String(data: base64decodedData, encoding: .utf8) else {
//                            return nil
//                        }
//                        return decodedString
//                    }
//                    .joined()
//            }
            
    }
}

// MARK: - Error mapping
private func decodeErrorMessage(from response: Response) -> String? {
    let data = response.data
    
    guard let firstLevel = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any],
          let errorMessage = firstLevel["message"] as? String ?? firstLevel["error"] as? String else {
        return nil
    }
    
    return errorMessage
}

private extension PrimitiveSequenceType where Trait == SingleTrait, Element == Response {
    func remapStatusErrors() -> Single<Element> {
        return self.primitiveSequence.map { response throws in
            if 200 ..< 300 ~= response.statusCode {
                return response
            } else {
                if response.statusCode == 403 {
                    throw NetworkError.authFailed
                }
                throw NetworkError.errorWithMessage(decodeErrorMessage(from: response) ?? "Unknown network error")
            }
        }
        .catchError { error -> PrimitiveSequence<SingleTrait, Element> in
            if let moyaError = error as? MoyaError,
               case let .underlying(underlyingError, _) = moyaError,
               let afError = underlyingError as? AFError,
               case let .sessionTaskFailed(sessionTaskError) = afError {
                if (sessionTaskError as NSError).code == NSURLErrorNotConnectedToInternet {
                    return .error(NetworkError.noInternet)
                }
            }
            return .error(error)
        }
    }
    
    func printContents() -> Single<Element> {
        return self.primitiveSequence.do(onSuccess: { response in
            if let decodedData = String(data: response.data, encoding: .utf8) {
                print(decodedData)
            }
        })
    }
}
