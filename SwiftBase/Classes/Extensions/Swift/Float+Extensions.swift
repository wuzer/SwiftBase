//
//  Float+Extensions.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public extension Float {
    var toInt: Int {
        return Int(self)
    }

    var toDouble: Double {
        return Double(self)
    }

    var toCGFloat: CGFloat {
        return CGFloat(self)
    }
}

public extension Float {
    // 保留几位小数
    func round(to places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
