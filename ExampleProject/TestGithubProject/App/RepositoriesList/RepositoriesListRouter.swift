//
//  RepositoriesListRouter.swift
//  TestGithubProject

//

final class RepositoriesListRouter: Router<RepositoriesListViewController>, RepositoriesListRouter.Routes {

    var openRepositoryDetailsTransition: Transition = PushTransition()
    
    typealias Routes = RepositoryDetailsRoute
}

protocol RepositoriesListRoute {
    var openRepositoriesListTransition: Transition { get }
    func openRepositoriesList()
}

extension RepositoriesListRoute where Self: RouterProtocol {
    func openRepositoriesList() {
        let router = RepositoriesListRouter()
        let viewController = RepositoriesListFabric.assembledScreen(router)
        openWithNextRouter(viewController, nextRouter: router, transition: openRepositoriesListTransition)
    }
}
