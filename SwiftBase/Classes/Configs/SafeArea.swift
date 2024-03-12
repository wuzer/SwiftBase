//
//  SafeArea.swift
//  TMSwiftBase_Example
//
//  Created by 张华康 on 2021/10/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
extension CGFloat {
    static var tm_topSafeAreaHeight: CGFloat {
        let window: UIWindow? = UIApplication.shared.delegate?.window ?? nil
        if let w = window {
            if #available(iOS 11.0, *) {
                return w.safeAreaInsets.top == 0 ? 20 : w.safeAreaInsets.top
            } else {
                return 20
            }
        } else {
            return 20
        }
    }
    
    static var tm_bottomSafeAreaHeight: CGFloat {
        let window: UIWindow? = UIApplication.shared.delegate?.window ?? nil
        if let w = window {
            if #available(iOS 11.0, *) {
                return w.safeAreaInsets.bottom == 0 ? 0 : w.safeAreaInsets.top
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
}
