//
//  FadeAnimator.swift
//  BytepaceSwiftUtils
//
//  Created by Ruslan Musagitov on 13.10.2020.
//  Copyright © 2020 Ruslan Musagitov. All rights reserved.
//

import UIKit

public final class FadeAnimator: NSObject, Animator {
    
    public var isPresenting: Bool = true
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.4
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            present(using: transitionContext)
        } else {
            dismiss(using: transitionContext)
        }
    }
    
    private func present(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        toViewController.view.alpha = 0
        containerView.addSubview(toViewController.view)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                toViewController.view.alpha = 1.0
            }, completion: { _ in
                transitionContext.completeTransition(true)
            })
    }
    
    private func dismiss(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else {
            return
        }
        guard let fromViewController = transitionContext.viewController(forKey: .from) else {
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        containerView.addSubview(fromViewController.view)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                fromViewController.view.alpha = 0.0
            }, completion: { _ in
                transitionContext.completeTransition(true)
            })
    }
}
