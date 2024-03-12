//
//  CGRect+Extensions.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public extension CGRect {
    /// 构造方法
    init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.init(x: x, y: y, width: w, height: h)
    }

    /// x
    var x: CGFloat {
        get {
            return self.origin.x
        } set(value) {
            self.origin.x = value
        }
    }
    
    /// y
    var y: CGFloat {
        get {
            return self.origin.y
        } set(value) {
            self.origin.y = value
        }
    }

    /// w
    var w: CGFloat {
        get {
            return self.size.width
        } set(value) {
            self.size.width = value
        }
    }

    /// h
    var h: CGFloat {
        get {
            return self.size.height
        } set(value) {
            self.size.height = value
        }
    }
    
    /// CGRectangle
    var area: CGFloat {
        return self.h * self.w
    }
}
