//
//  UISegmentedControl+Extensions.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/22.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public extension UISegmentedControl {
    /// segmentTitles
    var segmentTitles: [String] {
        get {
            let range = 0 ..< numberOfSegments
            return range.compactMap { titleForSegment(at: $0) }
        }
        set {
            removeAllSegments()
            for (index, title) in newValue.enumerated() {
                insertSegment(withTitle: title, at: index, animated: false)
            }
        }
    }

    /// segmentImages
    var segmentImages: [UIImage] {
        get {
            let range = 0 ..< numberOfSegments
            return range.compactMap { imageForSegment(at: $0) }
        }
        set {
            removeAllSegments()
            for (index, image) in newValue.enumerated() {
                insertSegment(with: image, at: index, animated: false)
            }
        }
    }
}
