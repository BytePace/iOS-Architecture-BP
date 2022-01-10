//
//  RepositoryDetailsFabric.swift
//  TestGithubProject
//

//

final class RepositoryDetailsFabric {
    class func assembledScreen(_ repository: GithubRepository,
                               _ router: RepositoryDetailsRouter = .init(),
                               networkService: NetworkServiceProtocol = NetworkService.shared) -> RepositoryDetailsViewController {
        let interactor = RepositoryDetailsInteractor(networkService, repository: repository)
        let presenter = RepositoryDetailsPresenter(router, interactor)
        let viewController = RepositoryDetailsViewController(presenter)
        router.viewController = viewController
        return viewController
    }
}
