//
//  RxPresenter.swift
//  BytepaceSwiftUtils
//
//  Created by Semen Ilin on 30.12.2020.
//

import Foundation
import UIKit

public protocol RxPresenter {
    associatedtype ViewController: UIViewController
    var router: Router<ViewController> { get set }
    associatedtype Input
    associatedtype Output

    func bindInput(_ input: Input)
    func configureOutput(_ input: Input) -> Output

    func buildOutput(with input: Input) -> Output
}

public extension RxPresenter {
    func buildOutput(with input: Input) -> Output {
        bindInput(input)

        let output = configureOutput(input)
        return output
    }
}
