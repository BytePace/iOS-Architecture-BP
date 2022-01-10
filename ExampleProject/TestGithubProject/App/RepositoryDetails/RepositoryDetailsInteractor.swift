//
//  RepositoryDetailsInteractor.swift
//  TestGithubProject
//

//

import RxSwift
import RxCocoa

final class RepositoryDetailsInteractor {
    private let disposeBag = DisposeBag()
    
    private let networkService: NetworkServiceProtocol
    
    init(_ networkService: NetworkServiceProtocol, repository: GithubRepository) {
        self.networkService = networkService
        
        repositoryRelay = .init(value: repository)
        
        setupBindings()
    }
    
    private func setupBindings() {
        
    }
    
    private let repositoryRelay: BehaviorRelay<GithubRepository>
    
    var repository: Observable<GithubRepository> {
        repositoryRelay.asObservable()
    }
    
    func getReadme() -> Single<String> {
        return repositoryRelay
            .take(1)
            .asSingle()
            .flatMap { [unowned self] repo -> Single<String> in
                networkService
                    .getRepositoryReadme(repo.owner.name, repo.name)
            }
    }
}
