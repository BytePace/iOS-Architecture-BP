//
//  RepositoriesListViewController.swift
//  CA-Github-Example
//
//  Created by Nikita Velichkin on 19/02/2020.
//  Copyright © 2020 Nikita Velichkin. All rights reserved.
//

import UIKit

final class RepositoriesListViewController: UIViewController {
    private let _view: RepositoriesListView
    private(set) var presenter: RepositoriesListPresenter
    
    init(_ presenter: RepositoriesListPresenter) {
        _view = RepositoriesListView(presenter)
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = _view
    }
}
