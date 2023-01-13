//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest

class ___VARIABLE_moduleName___Tests: XCTestCase {    
    private func makeSUT() -> ___VARIABLE_moduleName___ {
        let sut = ___VARIABLE_moduleName___()
        return sut
    }
}
extension ___VARIABLE_moduleName___Route where Self: RouterProtocol {
    func open___VARIABLE_moduleName___() {
        let router = ___VARIABLE_moduleName___Router()
        let viewController = ___VARIABLE_moduleName___Factory.assembledScreen(router)
        openWithNextRouter(viewController, nextRouter: router, transition: open___VARIABLE_moduleName___Transition)
    }
}
