//
//  UIScrollView+Extensions.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/22.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public extension UIScrollView {
    /// ScrollView区域截图
    var snapshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(contentSize, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let previousFrame = frame
        frame = CGRect(origin: frame.origin, size: contentSize)
        layer.render(in: context)
        frame = previousFrame
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
