//
//  UIView+Extensions.swift
//  BytepaceSwiftUtils
//
//  Created by Ruslan Musagitov on 10.12.2020.
//

import UIKit

public extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}

public enum ViewBorderName: String {
    case top
    case bottom
    case left
    case right
}

private extension CGFloat {
    static let defaultEstimatedRowHeight: CGFloat = 40
    static let defaultCornerRadius: CGFloat = 10
}

public extension UIView {
    
    func addTopCorners() {
        layer.maskedCorners = [.layerMaxXMinYCorner,
                                             .layerMinXMinYCorner]
    }
    
    func addAllCorners() {
        layer.maskedCorners = [.layerMaxXMaxYCorner,
                                             .layerMaxXMinYCorner,
                                             .layerMinXMaxYCorner,
                                             .layerMinXMinYCorner]
    }
    
    func addBottomCorners() {
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    @discardableResult func addRightBorder(color: UIColor, width: CGFloat) -> UIView {
        let layer: CALayer
        if let l = self.layer.sublayers?.first(where: { $0.name == ViewBorderName.right.rawValue }) {
            layer = l
        } else {
            layer = CALayer()
            self.layer.addSublayer(layer)
        }
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        return self
    }
    @discardableResult func addLeftBorder(color: UIColor, width: CGFloat) -> UIView {
        let layer: CALayer
        if let l = self.layer.sublayers?.first(where: { $0.name == ViewBorderName.left.rawValue }) {
            layer = l
        } else {
            layer = CALayer()
            self.layer.addSublayer(layer)
        }
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        return self
    }
    @discardableResult func addTopBorder(color: UIColor, width: CGFloat) -> UIView {
        let layer: CALayer
        if let l = self.layer.sublayers?.first(where: { $0.name == ViewBorderName.top.rawValue }) {
            layer = l
        } else {
            layer = CALayer()
            self.layer.addSublayer(layer)
        }
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        return self
    }
    @discardableResult func addBottomBorder(color: UIColor, height: CGFloat, width: CGFloat?) -> UIView {
        let layer: CALayer
        if let l = self.layer.sublayers?.first(where: { $0.name == ViewBorderName.bottom.rawValue }) {
            layer = l
        } else {
            layer = CALayer()
            self.layer.addSublayer(layer)
        }
        layer.borderColor = color.cgColor
        layer.borderWidth = height
        if let w = width {
            layer.frame = CGRect(x: (frame.width - w) / 2, y: self.frame.size.height - height, width: w, height: height)
        } else {
            layer.frame = CGRect(x: 0, y: self.frame.size.height - height, width: self.frame.size.width, height: height)
        }
        return self
    }
    
    func setRadius(radius: CGFloat? = nil) {
        self.layer.cornerRadius = radius ?? self.frame.width / 2;
        self.layer.masksToBounds = true;
    }
}

public extension Array where Element: UIView {
    func stackViews(below view: UIView, firstSpacing: CGFloat, horizontalMargin: CGFloat, interItemsMargin: CGFloat, height: CGFloat? = nil) {
        var prevView = view
        var i = 0
        forEach {
            if let h = height {
                $0.pin
                    .below(of: prevView)
                    .marginTop(i == 0 ? firstSpacing : interItemsMargin)
                    .horizontally(horizontalMargin)
                    .height(h)
                    .bottom(interItemsMargin)
            } else {
                $0.pin
                    .below(of: prevView)
                    .marginTop(i == 0 ? firstSpacing : interItemsMargin)
                    .horizontally(horizontalMargin)
                    .sizeToFit(.width)
                    .bottom(interItemsMargin)
            }
            prevView = $0
            i += 1
        }
    }
}

public extension UIView {
    func flip() {
        let isShowing = isHidden
        
        if isHidden {
            alpha = 0
            isHidden = false
        }
        
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]

        UIView.transition(with: self, duration: 1.0, options: transitionOptions) {
            if isShowing {
                self.alpha = 1
            } else {
                self.alpha = 0
            }
        } completion: { _ in
            if !isShowing {
                self.isHidden = true
            }
        }
    }
}
