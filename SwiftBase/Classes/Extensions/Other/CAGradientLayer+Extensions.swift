//
//  CAGradientLayer+Extensions.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public extension CAGradientLayer {
    /// 渐变颜色
    /// - Parameters:
    ///   - colors: 颜色数组
    ///   - locations: 颜色对应的位置数组
    ///   - startPoint: 开始位置
    ///   - endPoint: 结束位置
    ///   - type: Layer类型
    convenience init(colors: [UIColor], locations: [CGFloat]? = nil, startPoint: CGPoint, endPoint: CGPoint, type: CAGradientLayerType) {
        self.init()
        self.colors = colors.map { $0.cgColor }
        self.locations = locations?.map { NSNumber(value: Double($0)) }
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.type = type as String
    }
}
