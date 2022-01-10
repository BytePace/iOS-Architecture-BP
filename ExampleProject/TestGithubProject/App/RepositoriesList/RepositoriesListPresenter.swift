//
//  RepositoriesListPresenter.swift
//  TestGithubProject

//

import RxCocoa
import RxSwift
import RxSwiftExt
import RxSwiftUtilities

protocol RepositoriesListPresenterProtocol: RxPresenter {
    var router: Router<RepositoriesListViewController> { get }
    func buildOutput(with input: RepositoriesListPresenter.Input) -> RepositoriesListPresenter.Output
}

final class RepositoriesListPresenter {
    
    var router: Router<RepositoriesListViewController>
    private let interactor: RepositoriesListInteractor
    
    private let disposeBag = DisposeBag()
    
    private let repositories: BehaviorRelay<[GithubRepository]> = .init(value: [])
    
    private let activityIndicator = ActivityIndicator()

    init(_ router: Router<RepositoriesListViewController>, _ interactor: RepositoriesListInteractor) {
        self.router = router
        self.interactor = interactor
    }
}

extension RepositoriesListPresenter: RepositoriesListPresenterProtocol {
    struct Input {
        let searchText: Observable<String>
        let openDetails: Observable<GithubRepository>
    }

    struct Output {
        let repositories: Driver<[GithubRepository]>
        let isLoading: Driver<Bool>
    }

    func bindInput(_ input: RepositoriesListPresenter.Input) {
        input.searchText
            .flatMapLatest { [unowned self] searchText in
                interactor.searchRepositories(searchText)
                    .asObservable()
                    .trackActivity(activityIndicator)
                    .do(onError: { error in
                        print(error.localizedDescription)
                    })
                    .catchErrorJustComplete()
            }
            .bind(to: repositories)
            .disposed(by: disposeBag)
        
        input.openDetails
            .bind { [unowned self] repo in
                guard let detailsRoute = self.router as? RepositoryDetailsRoute else {
                    return
                }
                
                detailsRoute.openRepositoryDetails(for: repo)
            }
            .disposed(by: disposeBag)
    }

    func configureOutput(_ input: RepositoriesListPresenter.Input) -> RepositoriesListPresenter.Output {
        Output(
            repositories: repositories.asDriver(),
            isLoading: activityIndicator.asDriver()
        )
    }
}
