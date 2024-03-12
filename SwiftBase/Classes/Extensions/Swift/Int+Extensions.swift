//
//  Int+Extension.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public extension Int {
    /// 是否是偶数
    var isEven: Bool { return (self % 2 == 0) }

    /// 是否是奇数
    var isOdd: Bool { return (self % 2 != 0) }

    /// 是否是正数
    var isPositive: Bool { return (self > 0) }

    /// 是否是负数
    var isNegative: Bool { return (self < 0) }

    var toDouble: Double { return Double(self) }

    var toFloat: Float { return Float(self) }

    var toCGFloat: CGFloat { return CGFloat(self) }

    var toString: String { return String(self) }

    var toUInt: UInt { return UInt(self) }

    var toInt32: Int32 { return Int32(self) }

    /// for...in循环时使用
    /// for i in 9.range {}
    var range: CountableRange<Int> { return 0 ..< self }

    /// 5000 -> [5, 0, 0, 0]
    var digitArray: [Int] {
        var digits = [Int]()
        for char in toString {
            if let digit = Int(String(char)) {
                digits.append(digit)
            }
        }
        return digits
    }

    /// 位数
    var digitsCount: Int {
        guard self != 0 else { return 1 }
        return digitArray.count
    }

    /// 随机数
    static func random(within: Range<Int>) -> Int {
        let delta = within.upperBound - within.lowerBound
        return within.lowerBound + Int(arc4random_uniform(UInt32(delta)))
    }
}
