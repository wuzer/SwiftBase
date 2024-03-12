//
//  Data+Extensions.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

public extension Data {

    /// byte数组
    var bytes: [UInt8] {
        return [UInt8](self)
    }

}

// MARK: - Methods
public extension Data {

    /// -> toString
    func string(encoding: String.Encoding) -> String? {
        return String(data: self, encoding: encoding)
    }

    /// -> json对象
    func jsonObject(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        return try JSONSerialization.jsonObject(with: self, options: options)
    }

}
