//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class ___VARIABLE_moduleName___ViewController: UIViewController {
    typealias View = ___VARIABLE_moduleName___View
    weak var _view: View!
    
    override func loadView() {
        view = View()
        _view = view as! View
        
        bindButtons()
    }
    
    func bindButtons() {
        _view.nextCell.nextButton.addTarget(self, action: #selector(nextSelected), for: .touchUpInside)
    }
    
    @IBAction func nextSelected() {
    
    }
}

