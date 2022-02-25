//
//  UIViewController+ErrorDescription.swift
//  BytepaceSwiftUtils
//
//  Created by Maxim Seleznev on 2/17/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

public extension UIViewController {
    static func showAlertForError(for error: ErrorDescription, onVC vc: UIViewController? = nil) {
        guard let vc = vc ?? UIApplication.shared.windows.first?.rootViewController else {
            return
        }
        let alertVc = UIAlertController(title: "ERROR".localized, message: error.ownDescription, preferredStyle: .alert)
        alertVc.addAction(UIAlertAction(title: "ok".localized, style: .default, handler: nil))
        
        vc.present(alertVc, animated: true, completion: nil)
    }
}

public extension Reactive where Base: UIViewController {
    var showErrorAlert: Binder<ErrorDescription> {
        return .init(self.base) { viewController, errorDescription in
            UIViewController.showAlertForError(for: errorDescription,
                                               onVC: viewController)
        }
    }
}
