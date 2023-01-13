//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

final class ___VARIABLE_moduleName___Router: Router<___VARIABLE_moduleName___ViewController>, ___VARIABLE_moduleName___Router.Routes {

    typealias Routes = Any
}

protocol ___VARIABLE_moduleName___Route {
    var open___VARIABLE_moduleName___Transition: Transition { get }
    func open___VARIABLE_moduleName___()
}
extension ___VARIABLE_moduleName___Route where Self: RouterProtocol {
    func open___VARIABLE_moduleName___() {
        let router = ___VARIABLE_moduleName___Router()
        let viewController = ___VARIABLE_moduleName___Factory.assembledScreen(router)
        openWithNextRouter(viewController, nextRouter: router, transition: open___VARIABLE_moduleName___Transition)
    }
}
