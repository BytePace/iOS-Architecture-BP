//
//  RepositoriesListFabric.swift
//  TestGithubProject

//

final class RepositoriesListFabric {
    class func assembledScreen(_ router: RepositoriesListRouter = .init(),
                               networkSerivce: NetworkServiceProtocol = NetworkService.shared) -> RepositoriesListViewController {
        let interactor = RepositoriesListInteractor(networkSerivce)
        let presenter = RepositoriesListPresenter(router, interactor)
        let viewController = RepositoriesListViewController(presenter)
        router.viewController = viewController
        return viewController
    }
}
