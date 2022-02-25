//
//  UIAlertController+Rx.swift
//  BytepaceSwiftUtils
//
//  Created by Maxim Seleznev on 2/17/21.
//

import Foundation
import RxSwift

public extension UIAlertController {
    struct Action<T> {
        var title: String?
        var style: UIAlertAction.Style
        var value: T
        
        static func action(title: String?, style: UIAlertAction.Style = .default, value: T) -> Action {
            return Action(title: title, style: style, value: value)
        }
    }

    static func present<T>(in viewController: UIViewController,
                           title: String? = nil,
                           message: String? = nil,
                           style: UIAlertController.Style,
                           actions: [Action<T>]) -> Observable<T> {
        return Observable.create { observer in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
            
            actions.enumerated().forEach { _, action in
                let action = UIAlertAction(title: action.title, style: action.style) { _ in
                    observer.onNext(action.value)
                    observer.onCompleted()
                }
                alertController.addAction(action)
            }
            
            viewController.present(alertController, animated: true, completion: nil)
            return Disposables.create { alertController.dismiss(animated: true, completion: nil) }
        }
    }
}

