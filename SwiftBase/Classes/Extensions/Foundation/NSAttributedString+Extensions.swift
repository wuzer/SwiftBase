//
//  NSAttributedString+Extensions.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public extension NSAttributedString {

    /// 加粗
    func bold() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }

        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)], range: range)
        return copy
    }

    /// 下划线
    func underline() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }

        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.styleSingle.rawValue], range: range)
        return copy
    }


    /// 斜体
    func italic() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }

        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)], range: range)
        return copy
    }

    /// 删除线
    func strikethrough() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }

        let range = (self.string as NSString).range(of: self.string)
        let attributes = [
            NSAttributedString.Key.strikethroughStyle: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int)]
        copy.addAttributes(attributes, range: range)

        return copy
    }

    /// 颜色
    func color(_ color: UIColor) -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }

        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedString.Key.foregroundColor: color], range: range)
        return copy
    }
    
    /// 字体大小
    func systemFontSize(_ size: CGFloat) -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }

        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: size)], range: range)
        return copy
    }
    
    // 加粗字体大小
    func boldSystemFontSize(_ size: CGFloat) -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }

        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: size)], range: range)
        return copy
    }
}

// MARK: - Operators
public extension NSAttributedString {
    /// 相加
    static func += (left: inout NSAttributedString, right: NSAttributedString) {
        let ns = NSMutableAttributedString(attributedString: left)
        ns.append(right)
        left = ns
    }
        
    /// 相加
    static func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
        let ns = NSMutableAttributedString(attributedString: left)
        ns.append(right)
        return ns
    }
}
