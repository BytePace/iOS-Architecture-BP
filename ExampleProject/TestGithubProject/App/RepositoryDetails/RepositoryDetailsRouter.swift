//
//  RepositoryDetailsRouter.swift
//  TestGithubProject
//


final class RepositoryDetailsRouter: Router<RepositoryDetailsViewController>, RepositoryDetailsRouter.Routes {

    typealias Routes = URLRoute
}

protocol RepositoryDetailsRoute {
    var openRepositoryDetailsTransition: Transition { get }
    func openRepositoryDetails(for repository: GithubRepository)
}
extension RepositoryDetailsRoute where Self: RouterProtocol {
    func openRepositoryDetails(for repository: GithubRepository) {
        let router = RepositoryDetailsRouter()
        let viewController = RepositoryDetailsFabric.assembledScreen(repository, router)
        openWithNextRouter(viewController, nextRouter: router, transition: openRepositoryDetailsTransition)
    }
}
