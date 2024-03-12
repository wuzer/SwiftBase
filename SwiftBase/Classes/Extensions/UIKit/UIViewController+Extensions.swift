//
//  UIViewControllers.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public enum DCNavItemType {
    case itemLeft
    case itemRight
}

/// item默认尺寸
public struct itemSize {
    static let height: CGFloat = 40.0
    static let width: CGFloat = 40.0
    static let Font: CGFloat = 16.0
}

// MARK: - Properties

public extension UIViewController {
    /// 是否可见
    var isVisible: Bool {
        return isViewLoaded && view.window != nil
    }

    /// 隐藏或显示导航栏
    var isNavBarHidden: Bool {
        get {
            return (navigationController?.isNavigationBarHidden)!
        }
        set {
            navigationController?.isNavigationBarHidden = newValue
        }
    }

    /// 控制器的可见区域顶部  有导航控制器会排除
    var top: CGFloat {
        if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
            return visibleViewController.top
        }
        if let nav = self.navigationController {
            if nav.isNavigationBarHidden {
                return view.top
            } else {
                return nav.navigationBar.bottom
            }
        } else {
            return view.top
        }
    }

    /// 控制器的可见区域底部  有tabBar会排除
    var bottom: CGFloat {
        if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
            return visibleViewController.bottom
        }
        if let tab = tabBarController {
            if tab.tabBar.isHidden {
                return view.bottom
            } else {
                return tab.tabBar.top
            }
        } else {
            return view.bottom
        }
    }

    /// tabBar高度
    var tabBarHeight: CGFloat {
        if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
            return visibleViewController.tabBarHeight
        }
        if let tab = self.tabBarController {
            return tab.tabBar.frame.size.height
        }
        return 0
    }

    /// 导航栏高度
    var navigationBarHeight: CGFloat {
        if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
            return visibleViewController.navigationBarHeight
        }
        if let nav = self.navigationController {
            return nav.navigationBar.height
        }
        return 0
    }

    /// Navigation Bar's color
    var navigationBarColor: UIColor? {
        get {
            if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
                return visibleViewController.navigationBarColor
            }
            return navigationController?.navigationBar.tintColor
        } set(value) {
            navigationController?.navigationBar.barTintColor = value
        }
    }

    /// Navigation Bar
    var navBar: UINavigationBar? {
        return navigationController?.navigationBar
    }

    /// applicationFrame
    var applicationFrame: CGRect {
        return CGRect(x: view.left, y: top, width: view.width, height: bottom - top)
    }
}

// MARK: - NavItem Methods

extension UIViewController {
    /// 导航栏添加左右按钮
    ///
    /// - Parameters:
    ///   - navItemType: 位置
    ///   - imageName: 图片名称
    public func addNavItem(_ navItemType: DCNavItemType, imageName: String) {
        guard let btnImage = UIImage(named: imageName) else {
            return
        }
        let btn = UIButton(image: btnImage)
        addNavItem(navItemType: navItemType, button: btn)
    }

    /// 导航栏添加左右按钮
    ///
    /// - Parameters:
    ///   - navItemType: 位置
    ///   - itemTitle: 导航栏按钮文字
    ///   - titleColor: 导航栏按钮文字颜色
    public func addNavItem(_ navItemType: DCNavItemType, itemTitle: String, titleColor: UIColor) {
        let btn = UIButton(buttonTitle: itemTitle as NSString, titleColor: titleColor)
        addNavItem(navItemType: navItemType, button: btn)
    }

    /// 导航栏添加左右按钮
    ///
    /// - Parameters:
    ///   - navItemType: 位置
    ///   - button: UIButton
    public func addNavItem(navItemType: DCNavItemType, button: UIButton) {
        switch navItemType {
        case .itemLeft:
//            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: -19, bottom: 0, right: 0)
            navigationItem.leftBarButtonItem = nil
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
            button.addTarget(self, action: #selector(leftNavItemTouch), for: .touchUpInside)
        case .itemRight:
            navigationItem.rightBarButtonItem = nil
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
            button.addTarget(self, action: #selector(rightNavItemTouch), for: .touchUpInside)
        }
    }

    /// 导航栏左边按钮事件
    @objc open func leftNavItemTouch(button: UIButton) {}
    /// 导航栏右边按钮事件
    @objc open func rightNavItemTouch(button: UIButton) {}
}

// MARK: - Methods

public extension UIViewController {
    /// 添加子控制器
    func addChildViewController(_ child: UIViewController, toContainerView containerView: UIView) {
        addChildViewController(child)
        containerView.addSubview(child.view)
        child.didMove(toParentViewController: self)
    }

    /// 移除子控制器
    func removeViewAndControllerFromParentViewController() {
        guard parent != nil else { return }
        willMove(toParentViewController: nil)
        removeFromParentViewController()
        view.removeFromSuperview()
    }

    ///  自动检查控制器是否被销毁，添加在基类控制器的viewDidDisappear钟
    /// - Parameter delay: 延迟2秒检查
    func checkDeallocation(afterDelay delay: TimeInterval = 2.0) {
        let rootParentViewController = dch_rootParentViewController

        if isMovingFromParentViewController || rootParentViewController.isBeingDismissed {
            let disappearanceSource: String = isMovingFromParentViewController ? "removed from its parent" : "dismissed"
            DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: { [weak self] in
                if let VC = self {
                    assert(self == nil, "\(VC.description) not deallocated after being \(disappearanceSource)")
                }
            })
        }
    }

    private var dch_rootParentViewController: UIViewController {
        var root = self
        while let parent = root.parent {
            root = parent
        }
        return root
    }

    /// push
    func pushController(_ vc: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(vc, animated: animated)
    }

    /// pop
    func popController(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }

    /// pop到根控制器
    func popToRootController(animated: Bool = true) {
        navigationController?.popToRootViewController(animated: animated)
    }

    /// pop多层控制器
    func popController(times: Int, animated: Bool = true) {
        guard let count = self.navigationController?.viewControllers.count else {
            return
        }
        if (count - 1 - times) < navigationController?.viewControllers.count ?? 0,
            (count - 1 - times) >= 0,
            let valuevC = self.navigationController?.viewControllers[count - 1 - times] {
            navigationController?.popToViewController(valuevC, animated: animated)
        }
    }

    /// pop到指定类名的控制器
    ///
    /// - Parameters:
    ///   - ctrlClassName: 目标控制器名称
    func backToController(_ ctrlClassName: String, animated: Bool = true) {
        if let nav = navigationController {
            let controllers = nav.viewControllers
            let results = controllers.filter { vc -> Bool in
                ctrlClassName == String(describing: NSStringFromClass(type(of: vc)).split(separator: ".").last!)
            }

            if let vc = results.first {
                navigationController?.popToViewController(vc, animated: animated)
            }
        }
    }

    /// present
    func presentController(_ vc: UIViewController, animated: Bool = true, completion: (() -> Void)?) {
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: animated, completion: completion)
    }

    /// dismiss
    func dismissController(animated: Bool = true, completion: (() -> Void)?) {
        dismiss(animated: animated, completion: completion)
    }

    /// 类文件字符串转换为ViewController
    /// - Parameter controllerName: VC的字符串
    /// - Returns: ViewController
    static func getControllerByClassString(_ controllerName: String) -> UIViewController? {
        guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
            
            print("命名空间不存在")
            return nil
        }
        let cls: AnyClass? = NSClassFromString((clsName as! String) + "." + controllerName)
        guard let clsType = cls as? UIViewController.Type else {
            print("无法转换成UIViewController")
            return nil
        }
        let controller = clsType.init()
        return controller
    }
}
