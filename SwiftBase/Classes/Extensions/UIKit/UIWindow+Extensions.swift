//
//  UIWindow+Extensions.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

// MARK: - Initializers

public extension UIWindow {
    /// 构造方法
    convenience init(viewController: UIViewController, backgroundColor: UIColor) {
        self.init(frame: UIScreen.main.bounds)
        rootViewController = viewController
        self.backgroundColor = backgroundColor
        makeKeyAndVisible()
    }
}

// MARK: - Methods

public extension UIWindow {
    /// 切换根控制器
    func switchRootViewController(to viewController: UIViewController, animated: Bool = true, duration: TimeInterval = 0.5, options: UIView.AnimationOptions = .transitionFlipFromRight,
                                  _ completion: (() -> Void)? = nil) {
        guard animated else {
            rootViewController = viewController
            completion?()
            return
        }
        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }, completion: { _ in
            completion?()
        })
    }
}
