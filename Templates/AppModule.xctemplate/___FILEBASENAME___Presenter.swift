//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import RxCocoa
import RxSwift

protocol ___VARIABLE_moduleName___PresenterProtocol: RxPresenter {
    var router: Router<___VARIABLE_moduleName___ViewController> { get }
    func buildOutput(with input: ___VARIABLE_moduleName___Presenter.Input) -> ___VARIABLE_moduleName___Presenter.Output
}

final class ___VARIABLE_moduleName___Presenter {
    
    var router: Router<___VARIABLE_moduleName___ViewController>
    private let interactor: ___VARIABLE_moduleName___Interactor
    
    private let disposeBag = DisposeBag()

    init(_ router: Router<___VARIABLE_moduleName___ViewController>, _ interactor: ___VARIABLE_moduleName___Interactor) {
        self.router = router
        self.interactor = interactor
    }
}

extension ___VARIABLE_moduleName___Presenter: ___VARIABLE_moduleName___PresenterProtocol {
    struct Input {}

    struct Output {}

    func bindInput(_ input: ___VARIABLE_moduleName___Presenter.Input) {

    }

    func configureOutput(_ input: ___VARIABLE_moduleName___Presenter.Input) -> ___VARIABLE_moduleName___Presenter.Output {

        return Output()
    }
}
