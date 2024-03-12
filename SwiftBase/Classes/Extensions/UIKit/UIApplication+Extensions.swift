//
//  UIApplication+Extensions.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/18.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public extension UIApplication {
    /// 获取最顶部的控制器
    class func topViewController(_ base: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}
