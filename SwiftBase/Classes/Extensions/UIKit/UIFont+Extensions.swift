//
//  UIFont+Extensions.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public extension UIFont {
    class func fontOfSize(_ x: Double) -> UIFont {
        .systemFont(ofSize: CGFloat(x))
    }

    class func fontOfBoldSize(_ x: Double) -> UIFont {
        .boldSystemFont(ofSize: CGFloat(x))
    }

    class func fontOfMediumSize(_ x: Double) -> UIFont {
        .italicSystemFont(ofSize: CGFloat(x))
    }
}
