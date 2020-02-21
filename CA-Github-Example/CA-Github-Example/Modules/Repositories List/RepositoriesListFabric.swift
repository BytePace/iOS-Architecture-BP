//
//  RepositoriesListFabric.swift
//  CA-Github-Example
//
//  Created by Nikita Velichkin on 19/02/2020.
//  Copyright © 2020 Nikita Velichkin. All rights reserved.
//

final class RepositoriesListFabric {
    class func assembledScreen() -> RepositoriesListViewController {
            let interactor = RepositoriesListInteractor()
            let presenter = RepositoriesListPresenter(interactor)
            let viewController = RepositoriesListViewController(presenter)
            
            return viewController
    }
}
