//
//  RepositoryDetailsFabric.swift
//  CA-Github-Example
//
//  Created by Nikita Velichkin on 19/02/2020.
//  Copyright © 2020 Nikita Velichkin. All rights reserved.
//

final class RepositoryDetailsFabric {
    class func assembledScreen(repo: Repository) -> RepositoryDetailsViewController {
        let interactor = RepositoryDetailsInteractor(repository: repo)
        let presenter = RepositoryDetailsPresenter(interactor)
        let viewController = RepositoryDetailsViewController(presenter)

        return viewController
    }
}
