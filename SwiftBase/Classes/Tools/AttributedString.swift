//
//  AttributedString.swift
//  TMServiceReportModule_Example
//
//  Created by 张华康 on 2020/8/7.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

public extension NSMutableAttributedString {
    @discardableResult
    func append(_ text: String, font: UIFont? = .fontOfSize(14), color: UIColor? = .COLOR_333333) -> NSMutableAttributedString {
        guard !text.isEmpty else {
            return self
        }

        let attributedString = NSMutableAttributedString(string: text)
        attributedString.setAttributes([NSAttributedString.Key.foregroundColor: color!, NSAttributedString.Key.font: font!],
                                       range: NSRange(location: 0, length: attributedString.length))

        append(attributedString)
        return self
    }
}
