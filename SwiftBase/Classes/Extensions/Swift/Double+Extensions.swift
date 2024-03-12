//
//  Double+Extension.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator **: PowerPrecedence
public extension Double {
    var toString: String { return String(self) }

    var toInt: Int { return Int(self) }

    var toCGFloat: CGFloat { return CGFloat(self) }
    
    var toFloat: Float { return Float(self) }

    /// lhs的rhs次方
    static func ** (lhs: Double, rhs: Double) -> Double {
        return pow(lhs, rhs)
    }

    /// 绝对值
    var abs: Double {
        if self > 0 {
            return self
        } else {
            return -self
        }
    }
}

public extension Double {
    
    // 保留几位小数
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

