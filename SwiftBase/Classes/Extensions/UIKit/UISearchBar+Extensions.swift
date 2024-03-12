//
//  UISearchBar+Extensions.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/22.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

// MARK: - Properties

public extension UISearchBar {
    /// 获取textField
    var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return searchTextField
        }
        let subViews = subviews.flatMap { $0.subviews }
        guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
            return nil
        }
        return textField
    }

    /// 获取非空text
    var trimmedText: String? {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// MARK: - Methods

public extension UISearchBar {
    /// clear
    func clear() {
        text = ""
    }
}
