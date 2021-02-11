//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class ___VARIABLE_moduleName___ViewController: UIViewController {
    private let _view: ___VARIABLE_moduleName___View
    private var presenter: ___VARIABLE_moduleName___Presenter
    
    init(_ presenter: ___VARIABLE_moduleName___Presenter) {
        _view = ___VARIABLE_moduleName___View()
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = _view
    }
}


// MARK: - UI Bindings

extension ___VARIABLE_moduleName___ViewController {
    private func setupBindings() {
        let input = ___VARIABLE_moduleName___Presenter.Input()
        let output = presenter.buildOutput(with: input)
    }
}
