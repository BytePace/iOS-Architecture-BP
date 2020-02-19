//
//  RepositoryDetailsViewController.swift
//  CA-Github-Example
//
//  Created by Nikita Velichkin on 19/02/2020.
//  Copyright © 2020 Nikita Velichkin. All rights reserved.
//

import UIKit
import RxFlow

final class RepositoryDetailsViewController: UIViewController {
    private let _view: RepositoryDetailsView
    private(set) var stepper: Stepper
    
    init(_ presenter: RepositoryDetailsPresenter) {
        _view = RepositoryDetailsView(presenter)
        self.stepper = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = _view
    }
}
