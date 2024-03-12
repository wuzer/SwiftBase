//
//  UINavigationController+Extensions.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/22.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public extension UINavigationController {
    /// 带完成回调的push
    func pushViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
           CATransaction.begin()
           CATransaction.setCompletionBlock(completion)
           pushViewController(viewController, animated: true)
           CATransaction.commit()
       }
    /// 带完成回调的pop
    func popViewController(animated: Bool = true, _ completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
}
