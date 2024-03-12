//
//  Optional+Extension.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {

    /// 判断是否为空
    var isBlank: Bool {
        return self?.isBlank ?? true
    }
}

public extension Optional {
    /// 判断是否为空
    var isNone: Bool {
        switch self {
        case .none:
            return true
        case .some:
            return false
        }
    }

    /// 判断是否有值
    var isSome: Bool {
        return !isNone
    }
}

public extension Optional {
    /// 返回解包后的值或者默认值
    func or(_ default: Wrapped) -> Wrapped {
        return self ?? `default`
    }

    /// 返回解包后的值或`else`表达式的值
    func or(else: @autoclosure () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }

    /// 返回解包后的值或执行闭包返回值
    func or(else: () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }
}

public extension Optional {
    /// 当可选值不为空时，执行 `some` 闭包
    func on(some: () throws -> Void) rethrows {
        if self != nil { try some() }
    }

    /// 当可选值为空时，执行 `none` 闭包
    func on(none: () throws -> Void) rethrows {
        if self == nil { try none() }
    }
}

public extension Optional {
    /// 返回解包后的`map`过的值，如果为空，则返回默认值
    func map<T>(_ closure: (Wrapped) throws -> T, default: T) rethrows -> T {
        return try map(closure) ?? `default`
    }

    /// 返回解包后的`map`过的值，如果为空，则调用else闭包
    func map<T>(_ closure: (Wrapped) throws -> T, else: () throws -> T) rethrows -> T {
        return try map(closure) ?? `else`()
    }

    /// 可选值不为空时执行then闭包,返回执行结果
    /// 可链式调用
    func and<T>(then: (Wrapped) throws -> T?) rethrows -> T? {
        guard let unwrapped = self else { return nil }
        return try then(unwrapped)
    }

    /// 可选值不为空且可选值满足 `predicate` 条件才返回，否则返回 `nil`
    func filter(_ predicate: (Wrapped) -> Bool) -> Wrapped? {
        guard let unwrapped = self,
            predicate(unwrapped) else { return nil }
        return self
    }
}
