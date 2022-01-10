//
//  RepositoryDetailsPresenter.swift
//  TestGithubProject
//

//

import RxCocoa
import RxSwift
import RxSwiftExt
import RxSwiftUtilities
import BytepaceSwiftUtils

protocol RepositoryDetailsPresenterProtocol: RxPresenter {
    var router: Router<RepositoryDetailsViewController> { get }
    func buildOutput(with input: RepositoryDetailsPresenter.Input) -> RepositoryDetailsPresenter.Output
}

final class RepositoryDetailsPresenter {
    
    var router: Router<RepositoryDetailsViewController>
    private let interactor: RepositoryDetailsInteractor
    
    private let activityIndicator = ActivityIndicator()
    
    private let disposeBag = DisposeBag()

    init(_ router: Router<RepositoryDetailsViewController>, _ interactor: RepositoryDetailsInteractor) {
        self.router = router
        self.interactor = interactor
    }
}

extension RepositoryDetailsPresenter: RepositoryDetailsPresenterProtocol {
    struct Input {
        let linkTap: Observable<URL>
    }

    struct Output {
        let repository: Driver<GithubRepository>
        let readme: Driver<String>
        let isLoading: Driver<Bool>
    }

    func bindInput(_ input: RepositoryDetailsPresenter.Input) {
        
        input.linkTap
            .withLatestFrom(self.interactor.repository) { ($0, $1) }
            .compactMap { url, repository -> URL? in
                if url.host == nil {
                    let newUrl = URL(string: repository.url + url.path)
                    
                    return newUrl
                }
                return url
            }
            .bind { [unowned self] url in
                guard let urlRoute = self.router as? URLRoute else {
                    return
                }
                
                urlRoute.openUrl(url)
            }
            .disposed(by: disposeBag)
    }

    func configureOutput(_ input: RepositoryDetailsPresenter.Input) -> RepositoryDetailsPresenter.Output {
        let repository = self.interactor.repository.asDriver(onErrorDriveWith: .empty())
        
        let readme = repository
            .asObservable()
            .map { _ in () }
            .flatMapLatest { [unowned self] in
                self.interactor.getReadme()
                    .asObservable()
                    .trackActivity(activityIndicator)
                    .do(onError: { error in
                        print(error.localizedDescription)
                    })
                    .catchError { _ in .empty() }
            }
            .asDriver(onErrorDriveWith: .empty())
        
        return Output(repository: repository,
                      readme: readme,
                      isLoading: activityIndicator.asDriver())
    }
}
