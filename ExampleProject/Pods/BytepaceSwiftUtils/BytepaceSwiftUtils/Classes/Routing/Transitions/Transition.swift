//
//  Transition.swift
//  BytepaceSwiftUtils
//
//  Created by Ruslan Musagitov on 13.10.2020.
//  Copyright © 2020 Ruslan Musagitov. All rights reserved.
//

import Foundation
import UIKit

public protocol Transition: class {
    var viewController: UIViewController? { get set }

    func open(_ viewController: UIViewController)
    func close(_ viewController: UIViewController)
}
