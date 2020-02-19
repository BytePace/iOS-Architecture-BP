//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import RxFlow
import RxCocoa
import RxSwift

protocol ___VARIABLE_moduleName___PresenterProtocol {
    func buildOutput(with input: ___VARIABLE_moduleName___Presenter.Input) -> ___VARIABLE_moduleName___Presenter.Output
}

final class ___VARIABLE_moduleName___Presenter: Stepper {
    var steps = PublishRelay<Step>()

    private let interactor: ___VARIABLE_moduleName___Interactor
    private let disposeBag = DisposeBag()

    init(_ interactor: ___VARIABLE_moduleName___Interactor) {
        self.interactor = interactor
    }
}

extension ___VARIABLE_moduleName___Presenter: IsPresenter, ___VARIABLE_moduleName___PresenterProtocol {
    struct Input {}

    struct Output {}

    func bindInput(_ input: ___VARIABLE_moduleName___Presenter.Input) {

    }

    func configureOutput(_ input: ___VARIABLE_moduleName___Presenter.Input) -> ___VARIABLE_moduleName___Presenter.Output {

        return Output()
    }
}
