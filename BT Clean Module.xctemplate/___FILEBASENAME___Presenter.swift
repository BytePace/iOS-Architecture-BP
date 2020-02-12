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
    private let interactor: ___VARIABLE_moduleName___Interactor
    
    var steps = PublishRelay<Step>()
    
    init(_ interactor: ___VARIABLE_moduleName___Interactor) {
        self.interactor = interactor
    }
}

extension ___VARIABLE_moduleName___Presenter: ___VARIABLE_moduleName___PresenterProtocol {
    struct Input {}
    struct Output {}
    
    func buildOutput(with input: ___VARIABLE_moduleName___Presenter.Input) -> ___VARIABLE_moduleName___Presenter.Output {
        return Output()
    }
}
