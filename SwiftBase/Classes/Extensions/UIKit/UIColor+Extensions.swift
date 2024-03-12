//
//  UIColors.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

// MARK: - Properties

public extension UIColor {
    /// 获取红色数值
    var redComponent: Int {
        var r: CGFloat = 0
        getRed(&r, green: nil, blue: nil, alpha: nil)
        return Int(r * 255)
    }

    /// 获取绿色数值
    var greenComponent: Int {
        var g: CGFloat = 0
        getRed(nil, green: &g, blue: nil, alpha: nil)
        return Int(g * 255)
    }

    /// 获取蓝色数值
    var blueComponent: Int {
        var b: CGFloat = 0
        getRed(nil, green: nil, blue: &b, alpha: nil)
        return Int(b * 255)
    }

    /// 获取alpha数值
    var alpha: CGFloat {
        var a: CGFloat = 0
        getRed(nil, green: nil, blue: nil, alpha: &a)
        return a
    }
}

// MARK: - Initializers

public extension UIColor {
    /// UIColor(23, 24, 25)
    convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }

    /// 设置灰色值
    convenience init(gray: CGFloat, alpha: CGFloat = 1) {
        self.init(red: gray / 255, green: gray / 255, blue: gray / 255, alpha: alpha)
    }

    /// 十六进制颜色转换
    convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if let hex = Int(formatted, radix: 16) {
            let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16) / 255.0)
            let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8) / 255.0)
            let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0) / 255.0)
            self.init(red: red, green: green, blue: blue, alpha: alpha)

        } else {
            return nil
        }
    }
    
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16) / 255.0)
        let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8) / 255.0)
        let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0) / 255.0)
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    convenience init(tm_hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat(CGFloat((tm_hex & 0xFF0000) >> 16) / 255.0)
        let green = CGFloat(CGFloat((tm_hex & 0x00FF00) >> 8) / 255.0)
        let blue = CGFloat(CGFloat((tm_hex & 0x0000FF) >> 0) / 255.0)
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

// MARK: - Methods

public extension UIColor {
    /// 随机颜色
    static func random(randomAlpha: Bool = false) -> UIColor {
        let randomRed = CGFloat.random()
        let randomGreen = CGFloat.random()
        let randomBlue = CGFloat.random()
        let alpha = randomAlpha ? CGFloat.random() : 1.0
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: alpha)
    }
    
    /// 判断是否是深色
    func isDarkColor() -> Bool {
        var w: CGFloat = 0
        self.getWhite(&w, alpha: nil)
        return w > 0.5 ? false : true
    }
}
