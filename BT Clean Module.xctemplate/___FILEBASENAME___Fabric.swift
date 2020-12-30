//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

final class ___VARIABLE_moduleName___Fabric {
    class func assembledScreen() -> ___VARIABLE_moduleName___ViewController {
        
        let router = ___VARIABLE_moduleName___Router()
        let interactor = ___VARIABLE_moduleName___Interactor()
        let presenter = ___VARIABLE_moduleName___Presenter(router, interactor)
        let viewController = ___VARIABLE_moduleName___ViewController(presenter)
        router.viewController = viewController
        return viewController
    }
}
