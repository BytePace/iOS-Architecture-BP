//
//  StartFlow.swift
//  CA-Github-Example
//
//  Created by Nikita Velichkin on 19/02/2020.
//  Copyright © 2020 Nikita Velichkin. All rights reserved.
//

import RxFlow

class StartFlow: Flow {
    var root: Presentable {
        return self.navigationController
    }

    private lazy var navigationController: UINavigationController = {
        let nc = UINavigationController()
        nc.view.backgroundColor = .white
        
        return nc
    }()

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? RouteStep else { return .none }

        switch step {

        case .repoList:
            return navigateToRepoList()

        case let .repoDetails(repo):
            return navigateToRepoDetails(repo: repo)

        }
    }
}

extension StartFlow {
    private func navigateToRepoList() -> FlowContributors {
        let vc = RepositoriesListFabric.assembledScreen()
        navigationController.pushViewController(vc, animated: true)

        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.presenter))
    }

    private func navigateToRepoDetails(repo: Repository) -> FlowContributors {
        let vc = RepositoryDetailsFabric.assembledScreen(repo: repo)
        navigationController.pushViewController(vc, animated: true)

        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.presenter))
    }
}
