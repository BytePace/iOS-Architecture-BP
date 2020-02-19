//
//  UIView + Extensions.swift
//
//  Created by Nikita Velichkin on 25/01/2020.
//  Copyright © 2020 Nikita Velichkin. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach(addSubview(_:))
    }
}
