//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxFlow

final class ___VARIABLE_moduleName___ViewController: UIViewController {
    private let _view: ___VARIABLE_moduleName___View
    private(set) var stepper: Stepper
    
    init(_ presenter: ___VARIABLE_moduleName___Presenter) {
        _view = ___VARIABLE_moduleName___View(presenter)
        self.stepper = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = _view
    }
}
