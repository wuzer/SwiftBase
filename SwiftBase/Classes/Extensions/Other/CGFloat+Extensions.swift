//
//  CGFloat+Extension.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public extension CGFloat {
    /// 随机数 0~1之间
    static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(0xFFFFFFFF))
    }
}

public extension CGFloat {
    /// 绝对值
    var abs: CGFloat {
        return Swift.abs(self)
    }
    
    /// 向上取整
    var ceil: CGFloat {
        return Foundation.ceil(self)
    }
    
    /// 弧度
    var degreesToRadians: CGFloat {
        return .pi * self / 180.0
    }
    
    /// 向下取整
    var floor: CGFloat {
        return Foundation.floor(self)
    }
    
    /// 是否正数
    var isPositive: Bool {
        return self > 0
    }
    
    /// 是否负数
    var isNegative: Bool {
        return self < 0
    }
    
    var toInt: Int {
        return Int(self)
    }
    
    var toFloat: Float {
        return Float(self)
    }
    
    var toDouble: Double {
        return Double(self)
    }
    
    /// 屏幕宽度
    static var screenWidth: CGFloat {
        return Swift.min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
    }
    
    /// 屏幕高度
    static var screenHeight: CGFloat {
        return Swift.max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
    }
    
    /// 状态栏高度
    static var statusBarHeight: CGFloat {
        guard let window = UIApplication.shared.windows.first else {
          // 处理没有 window 的情况
          return 36
        }
        let windowScene = window.windowScene
        return windowScene?.statusBarManager?.statusBarFrame.height ?? 36
    }
    
    /// 没有状态栏高度的屏幕高度
    static var screenHeightWithoutStatusBar: CGFloat {
        return .screenHeight - statusBarHeight
        
    }
    
    /// 刘海屏底部高度
    static var bottomPadding: CGFloat {
        if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.windows.first else {
              // 处理没有 window 的情况
              return 0
            }
            return window.safeAreaInsets.bottom
        }else {
            return 0
        }
    }
    
    static var topPadding: CGFloat {
        if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.windows.first else {
              // 处理没有 window 的情况
              return 0
            }
            return window.safeAreaInsets.top
        }else {
            return 0
        }
    }
}
