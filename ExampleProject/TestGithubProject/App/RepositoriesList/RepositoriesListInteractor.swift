//
//  RepositoriesListInteractor.swift
//  TestGithubProject

//

import RxSwift
import RxCocoa

final class RepositoriesListInteractor {
    private let disposeBag = DisposeBag()
    
    private let networkService: NetworkServiceProtocol
    
    init(_ networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func searchRepositories(_ searchString: String) -> Single<[GithubRepository]> {
        networkService
            .searchRepositories(searchString)
    }
}
