//
//  Toast.swift
//  BytepaceSwiftUtils
//
//  Created by Semen Ilin on 2/17/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import PinLayout

private extension CGFloat {
    static let toastCornerRadius: CGFloat = 14
    static let toastFullHorizontalMargin: CGFloat = 40
    static let toastBackgroundAlpha: CGFloat = 0.95
    static let toastLabelHorizontalMargin: CGFloat = 14
    static let toastLabelVerticalMargin: CGFloat = 11
    static let toastTopMargin: CGFloat = 90
}

class Toast: UIView {
    static let fadeAnimationLength: TimeInterval = 0.25
    private lazy var toastLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        configureUI()
    }
    
    convenience init(_ toastText: String) {
        self.init(frame: .zero)
        toastLabel.text = toastText
        setNeedsLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubviews(toastLabel)
    }
    
    private func configureUI() {
        layer.cornerRadius = .toastCornerRadius
        backgroundColor = UIColor.orange.withAlphaComponent(.toastBackgroundAlpha)
        toastLabel.textColor = .white
        toastLabel.font = .preferredFont(forTextStyle: .footnote)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        performLayout()
    }
    
    private func performLayout() {
        pin
            .horizontally(.toastFullHorizontalMargin)
        
        toastLabel.pin
            .horizontally(.toastLabelHorizontalMargin)
            .sizeToFit(.widthFlexible)
        
        pin
            .wrapContent(padding: .init(top: .toastLabelVerticalMargin,
                                        left: .toastLabelHorizontalMargin,
                                        bottom: .toastLabelVerticalMargin,
                                        right: .toastLabelHorizontalMargin))
            .top(pin.safeArea)
            .marginTop(.toastTopMargin)
            .hCenter()
    }
}

public extension UIViewController {
    func showToast(toastText: String, showInterval: TimeInterval = 2) {
        let toast = Toast(toastText)
        toast.alpha = 0
        view.addSubviews(toast)
        view.bringSubviewToFront(toast)
        toast.setNeedsLayout()
        
        UIView.animate(withDuration: Toast.fadeAnimationLength,
                       animations: {
                        toast.alpha = 1
                       },
                       completion: { _ in
                        UIView.animate(withDuration: Toast.fadeAnimationLength,
                                       delay: showInterval,
                                       options: [],
                                       animations: {
                                        toast.alpha = 0
                                       },
                                       completion: { _ in
                                        toast.removeFromSuperview()
                                       })
                       })
    }
    
    static func showToast(toastText: String, showInterval: TimeInterval = 2) {
        UIApplication.shared.windows.first?.rootViewController?.showToast(toastText: toastText, showInterval: showInterval)
    }
}

//MARK:- Toasts + RX

extension Reactive where Base: UIViewController {
    func showToast(withDuration duration: TimeInterval = 2) -> Binder<String> {
        return .init(self.base) { viewController, toastMessage in
            UIViewController.showToast(toastText: toastMessage, showInterval: duration)
        }
    }
}
