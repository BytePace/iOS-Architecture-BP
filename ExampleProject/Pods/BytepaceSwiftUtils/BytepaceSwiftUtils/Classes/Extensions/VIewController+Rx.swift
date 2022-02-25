//
//  ViewController+Rx.swift
//  BytepaceSwiftUtils
//
//  Created by Maxim Seleznev on 3/30/21.
//

import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UIViewController {
    var onAppearAfterPop: Observable<Void> {
        self.base.rx.methodInvoked(#selector(UIViewController.viewDidAppear(_:)))
            .compactMap { $0 }
            .filter { [weak base = self.base] _ in
                !(base?.isMovingFromParent ?? true)
            }
            .map { _ in () }
    }
}
