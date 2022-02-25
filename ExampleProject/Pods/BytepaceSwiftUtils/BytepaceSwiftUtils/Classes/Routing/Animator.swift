//
//  Animator.swift
//  BytepaceSwiftUtils
//
//  Created by Ruslan Musagitov on 13.10.2020.
//  Copyright © 2020 Ruslan Musagitov. All rights reserved.
//

import UIKit

public protocol Animator: UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool { get set }
}
