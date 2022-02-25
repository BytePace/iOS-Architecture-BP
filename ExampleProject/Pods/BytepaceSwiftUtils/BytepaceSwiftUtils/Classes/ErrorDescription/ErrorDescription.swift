//
//  ErrorDescription.swift
//  BytepaceSwiftUtils
//
//  Created by Maxim Seleznev on 2/17/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

public protocol ErrorDescription {
    var ownDescription: String { get }
}

public enum SimpleError: Error, ErrorDescription {
    case error(_ description: String)
    public var ownDescription: String {
        switch self {
        case let .error(description):
            return description
        }
    }
}

public extension RxPresenter {
    func showAlertForError(_ error: ErrorDescription) {
        UIViewController.showAlertForError(for: error)
    }
}
