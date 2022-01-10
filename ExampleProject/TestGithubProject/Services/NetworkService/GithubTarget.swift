//
//  GithubTarget.swift
//  TestGithubProject
import Foundation
import Moya

enum GithubTarget {
    case searchRepositories(_ searchString: String)
    case getRepositoryDetails(_ ownerName: String, _ repoName: String)
    case getRepositoryReadme(_ ownerName: String, _ repoName: String)
}

extension GithubTarget: TargetType {
    var baseURL: URL {
        guard let baseUrl = URL(string: "https://api.github.com") else {
            fatalError("Failed to create baseurl")
        }
        
        return baseUrl
    }
    
    var path: String {
        switch self {
        case let .getRepositoryDetails(ownerName, repoName):
            return "/repos/\(ownerName)/\(repoName)"
        case let .getRepositoryReadme(ownerName, repoName):
            return "/repos/\(ownerName)/\(repoName)/readme"
        case .searchRepositories:
            return "/search/repositories"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .searchRepositories,
             .getRepositoryDetails,
             .getRepositoryReadme:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var parameters: [String: Any] {
        var parameters: [String: Any] = [:]
        
        switch self {
        case let .searchRepositories(searchString):
            parameters["q"] = searchString
        default:
            break
        }
        
        return parameters
    }
    
    var task: Task {
        switch self.method {
        case .get:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .post:
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        var headers: [String: String] = [:]
        
        headers["Accept"] = "application/vnd.github.v3+json"
        
        switch self {
        case .getRepositoryReadme:
            headers["Accept"] = "application/vnd.github.v3.html+json"
        default:
            break
        }
        
        return headers
    }
}
