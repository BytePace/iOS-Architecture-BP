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
    private let presenter: ___VARIABLE_moduleName___Presenter
    
    init(_ presenter: ___VARIABLE_moduleName___Presenter) {
        _view = ___VARIABLE_moduleName___View(presenter)
        self.presenter = presenter
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
