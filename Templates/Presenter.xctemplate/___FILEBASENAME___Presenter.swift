//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

protocol ___VARIABLE_moduleName___PresenterProtocol {
    var router: Router<___VARIABLE_moduleName___ViewController> { get }
    var interactor: ___VARIABLE_moduleName___InteractorProtocol { get }
}

final class ___VARIABLE_moduleName___Presenter {
    let router: Router<___VARIABLE_moduleName___ViewController>
    let interactor: ___VARIABLE_moduleName___Interactor

    init(_ router: Router<___VARIABLE_moduleName___ViewController>, _ interactor: ___VARIABLE_moduleName___Interactor) {
        self.router = router
        self.interactor = interactor

        setupInput()
    }

    private func setupInput() {}
}

extension ___VARIABLE_moduleName___Presenter: ___VARIABLE_moduleName___PresenterProtocol {
    struct Input {}

    struct Output {}
}
