//
//  Bool+Extension.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

public extension Bool {
    /// 转Int类型
    var toInt: Int { return self ? 1 : 0 }

    /// 转String
    var toString: String { return self ? "true" : "false" }
    /// 切换
    @discardableResult
    mutating func toggle() -> Bool {
        self = !self
        return self
    }

    /// 切换
    var toggled: Bool {
        return !self
    }
    
}
