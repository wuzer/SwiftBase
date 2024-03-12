//
//  Character+Extensions.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

public extension Character {
    /// toString
    var toString: String { return String(self) }

    /// toInt
    var toInt: Int? { return Int(String(self)) }

    /// 小写
    var lowercased: Character {
        let s = String(self).lowercased()
        return s[s.startIndex]
    }

    /// 大写
    var uppercased: Character {
        let s = String(self).uppercased()
        return s[s.startIndex]
    }

    /// isEmoji
    var isEmoji: Bool {
        return String(self).includesEmoji()
    }
}

// MARK: - Operators
public extension Character {

    /// Character乘以
    ///
    /// eg. Character("-") * 10 -> "----------"
    static func * (lhs: Character, rhs: Int) -> String {
        guard rhs > 0 else { return "" }
        return String(repeating: String(lhs), count: rhs)
    }

    /// Character乘以
    ///
    /// eg. 10 * Character("-") -> "----------"
    static func * (lhs: Int, rhs: Character) -> String {
        guard lhs > 0 else { return "" }
        return String(repeating: String(rhs), count: lhs)
    }

}
