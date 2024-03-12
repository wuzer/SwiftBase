//
//  String+Extensions.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/18.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public extension String {
    /// base64转字符串
    init ? (base64: String) {
        let pad = String(repeating: "=", count: base64.length % 4)
        let base64Padded = base64 + pad
        if let decodedData = Data(base64Encoded: base64Padded, options: NSData.Base64DecodingOptions(rawValue: 0)), let decodedString = NSString(data: decodedData, encoding: String.Encoding.utf8.rawValue) {
            self.init(decodedString)
            return
        }
        return nil
    }

    /// 字符串转base64
    var base64 : String {
        let plainData = (self as NSString).data(using: String.Encoding.utf8.rawValue)
        let base64String = plainData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64String
    }

    /// 获取对应索引的元素
    subscript(integerIndex: Int) -> Character {
        let index = self.index(startIndex, offsetBy: integerIndex)
        return self[index]
    }

    /// 获取范围内的字符串
    subscript(integerRange: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: integerRange.lowerBound)
        let end = index(startIndex, offsetBy: integerRange.upperBound)
        return String(self[start ..< end])
    }

    /// 获取闭区间范围内的字符串
    subscript(integerClosedRange: ClosedRange<Int>) -> String {
        return self[integerClosedRange.lowerBound ..< (integerClosedRange.upperBound + 1)]
    }

    /// 字符串长度
    var length: Int {
        return count
    }

    /// 包含输入字符串个数
    func count(_ substring: String) -> Int {
        return components(separatedBy: substring).count - 1
    }

    /// 第一个字母大写（修改原字符串）
    mutating func capitalizeFirst() {
        guard count > 0 else { return }
        replaceSubrange(startIndex ... startIndex, with: String(self[startIndex]).capitalized)
    }

    /// 第一个字母大写（返回新字符串）
    func capitalizedFirst() -> String {
        guard count > 0 else { return self }
        var result = self

        result.replaceSubrange(startIndex ... startIndex, with: String(self[startIndex]).capitalized)
        return result
    }

    /// 前置元素大写（修改原字符串）
    mutating func uppercasePrefix(_ count: Int) {
        guard self.count > 0 && count > 0 else { return }
        replaceSubrange(startIndex ..< index(startIndex, offsetBy: min(count, length)),
                        with: String(self[startIndex ..< index(startIndex, offsetBy: min(count, length))]).uppercased())
    }

    /// 前置位置元素大写（返回新字符串）
    func uppercasedPrefix(_ count: Int) -> String {
        guard self.count > 0 && count > 0 else { return self }
        var result = self
        result.replaceSubrange(startIndex ..< index(startIndex, offsetBy: min(count, length)),
                               with: String(self[startIndex ..< index(startIndex, offsetBy: min(count, length))]).uppercased())
        return result
    }

    /// 后置元素大写（修改原字符串）
    mutating func uppercaseSuffix(_ count: Int) {
        guard self.count > 0 && count > 0 else { return }
        replaceSubrange(index(endIndex, offsetBy: -min(count, length)) ..< endIndex,
                        with: String(self[index(endIndex, offsetBy: -min(count, length)) ..< endIndex]).uppercased())
    }

    /// 后置元素大写（返回新字符串）
    func uppercasedSuffix(_ count: Int) -> String {
        guard self.count > 0 && count > 0 else { return self }
        var result = self
        result.replaceSubrange(index(endIndex, offsetBy: -min(count, length)) ..< endIndex,
                               with: String(self[index(endIndex, offsetBy: -min(count, length)) ..< endIndex]).uppercased())
        return result
    }

    /// 范围内的字符串大写
    mutating func uppercase(range: CountableRange<Int>) {
        let from = max(range.lowerBound, 0), to = min(range.upperBound, length)
        guard count > 0 && (0 ..< length).contains(from) else { return }
        replaceSubrange(index(startIndex, offsetBy: from) ..< index(startIndex, offsetBy: to),
                        with: String(self[index(startIndex, offsetBy: from) ..< index(startIndex, offsetBy: to)]).uppercased())
    }

    /// 范围内的字符串大写
    func uppercased(range: CountableRange<Int>) -> String {
        let from = max(range.lowerBound, 0), to = min(range.upperBound, length)
        guard count > 0 && (0 ..< length).contains(from) else { return self }
        var result = self
        result.replaceSubrange(index(startIndex, offsetBy: from) ..< index(startIndex, offsetBy: to),
                               with: String(self[index(startIndex, offsetBy: from) ..< index(startIndex, offsetBy: to)]).uppercased())
        return result
    }

    /// 第一个字符小写
    mutating func lowercaseFirst() {
        guard count > 0 else { return }
        replaceSubrange(startIndex ... startIndex, with: String(self[startIndex]).lowercased())
    }

    ///  第一个字符小写
    func lowercasedFirst() -> String {
        guard count > 0 else { return self }
        var result = self
        result.replaceSubrange(startIndex ... startIndex, with: String(self[startIndex]).lowercased())
        return result
    }

    /// 前置字符串小写
    mutating func lowercasePrefix(_ count: Int) {
        guard self.count > 0 && count > 0 else { return }
        replaceSubrange(startIndex ..< index(startIndex, offsetBy: min(count, length)),
                        with: String(self[startIndex ..< index(startIndex, offsetBy: min(count, length))]).lowercased())
    }

    /// 前置字符串小写
    func lowercasedPrefix(_ count: Int) -> String {
        guard self.count > 0 && count > 0 else { return self }
        var result = self
        result.replaceSubrange(startIndex ..< index(startIndex, offsetBy: min(count, length)),
                               with: String(self[startIndex ..< index(startIndex, offsetBy: min(count, length))]).lowercased())
        return result
    }

    /// 后置字符串小写
    mutating func lowercaseSuffix(_ count: Int) {
        guard self.count > 0 && count > 0 else { return }
        replaceSubrange(index(endIndex, offsetBy: -min(count, length)) ..< endIndex,
                        with: String(self[index(endIndex, offsetBy: -min(count, length)) ..< endIndex]).lowercased())
    }

    /// 后置字符串小写
    func lowercasedSuffix(_ count: Int) -> String {
        guard self.count > 0 && count > 0 else { return self }
        var result = self
        result.replaceSubrange(index(endIndex, offsetBy: -min(count, length)) ..< endIndex,
                               with: String(self[index(endIndex, offsetBy: -min(count, length)) ..< endIndex]).lowercased())
        return result
    }

    /// 范围内字符串小写
    mutating func lowercase(range: CountableRange<Int>) {
        let from = max(range.lowerBound, 0), to = min(range.upperBound, length)
        guard count > 0 && (0 ..< length).contains(from) else { return }
        replaceSubrange(index(startIndex, offsetBy: from) ..< index(startIndex, offsetBy: to),
                        with: String(self[index(startIndex, offsetBy: from) ..< index(startIndex, offsetBy: to)]).lowercased())
    }

    /// 范围内字符串小写
    func lowercased(range: CountableRange<Int>) -> String {
        let from = max(range.lowerBound, 0), to = min(range.upperBound, length)
        guard count > 0 && (0 ..< length).contains(from) else { return self }
        var result = self
        result.replaceSubrange(index(startIndex, offsetBy: from) ..< index(startIndex, offsetBy: to),
                               with: String(self[index(startIndex, offsetBy: from) ..< index(startIndex, offsetBy: to)]).lowercased())
        return result
    }

    /// 是否是空字符串（空格 换行符）
    var isBlank: Bool {
        return allSatisfy({ $0.isWhitespace })
    }

    /// 去除空格和换行符
    mutating func trim() {
        self = trimmed()
    }

    /// 去除空格和换行符
    func trimmed() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// 最先字符索引
    func positionOfSubstring(_ subString: String, caseInsensitive: Bool = false, fromEnd: Bool = false) -> Int {
        if subString.isEmpty {
            return -1
        }
        var searchOption = fromEnd ? NSString.CompareOptions.anchored : NSString.CompareOptions.backwards
        if caseInsensitive {
            searchOption.insert(NSString.CompareOptions.caseInsensitive)
        }
        if let range = self.range(of: subString, options: searchOption), !range.isEmpty {
            return distance(from: startIndex, to: range.lowerBound)
        }
        return -1
    }

    /// 分割字符串
    func split(_ separator: String) -> [String] {
        return components(separatedBy: separator).filter {
            !$0.trimmed().isEmpty
        }
    }

    /// 分割字符串
    func split(_ characters: CharacterSet) -> [String] {
        return components(separatedBy: characters).filter {
            !$0.trimmed().isEmpty
        }
    }

    /// 统计单词个数
    var countofWords: Int {
        let regex = try? NSRegularExpression(pattern: "\\w+", options: NSRegularExpression.Options())
        return regex?.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: length)) ?? 0
    }

    /// 统计段落个数
    var countofParagraphs: Int {
        let regex = try? NSRegularExpression(pattern: "\\n", options: NSRegularExpression.Options())
        let str = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return (regex?.numberOfMatches(in: str, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: str.length)) ?? -1) + 1
    }

    internal func rangeFromNSRange(_ nsRange: NSRange) -> Range<String.Index>? {
        let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location)
        let to16 = utf16.index(from16, offsetBy: nsRange.length)
        if let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self) {
            return from ..< to
        }
        return nil
    }

    /// 正则匹配
    func matchesForRegexInText(_ regex: String!) -> [String] {
        let regex = try? NSRegularExpression(pattern: regex, options: [])
        let results = regex?.matches(in: self, options: [], range: NSRange(location: 0, length: length)) ?? []
        return results.map { String(self[self.rangeFromNSRange($0.range)!]) }
    }

    /// 检出是否是邮箱
    var isEmail: Bool {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let firstMatch = dataDetector?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: length))
        return (firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto")
    }

    /// isNumber
    func isNumber() -> Bool {
        return NumberFormatter().number(from: self) != nil ? true : false
    }

    /// 字符串中提取URL
    var extractURLs: [URL] {
        var urls: [URL] = []
        let detector: NSDataDetector?
        do {
            detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        } catch _ as NSError {
            detector = nil
        }

        let text = self

        if let detector = detector {
            detector.enumerateMatches(in: text,
                                      options: [],
                                      range: NSRange(location: 0, length: text.count),
                                      using: { (result: NSTextCheckingResult?, _, _) -> Void in
                                          if let result = result, let url = result.url {
                                              urls.append(url)
                                          }
                                      })
        }

        return urls
    }

    /// 是否包含字符串
    func contains(_ find: String, compareOption: NSString.CompareOptions) -> Bool {
        return range(of: find, options: compareOption) != nil
    }

    func toInt() -> Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }

    func toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }

    func toFloat() -> Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }

    func toBool() -> Bool? {
        let trimmedString = trimmed().lowercased()
        if trimmedString == "true" || trimmedString == "false" {
            return (trimmedString as NSString).boolValue
        }
        return nil
    }

    // 获取索引
    func getIndexOf(_ char: Character) -> Int? {
        for (index, c) in enumerated() where c == char {
            return index
        }
        return nil
    }

    var toNSString: NSString { return self as NSString }

    /// 加粗
    func bold() -> NSAttributedString {
        let boldString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
        return boldString
    }

    /// 加下划线
    func underline() -> NSAttributedString {
        let underlineString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        return underlineString
    }

    /// 加斜体
    func italic() -> NSAttributedString {
        let italicString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
        return italicString
    }

    /// 返回字符串的高度
    func height(_ width: CGFloat, font: UIFont, lineBreakMode: NSLineBreakMode?) -> CGFloat {
        var attrib: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
        if lineBreakMode != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = lineBreakMode!
            attrib.updateValue(paragraphStyle, forKey: NSAttributedString.Key.paragraphStyle)
        }
        let size = CGSize(width: width, height: CGFloat(Double.greatestFiniteMagnitude))
        return ceil((self as NSString).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attrib, context: nil).height)
    }

    func height(_ width: CGFloat, font: UIFont, lineBreakMode: NSLineBreakMode?, lineSpace: CGFloat?) -> CGFloat {
        var attrib: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
        if lineBreakMode != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = lineBreakMode!
            attrib.updateValue(paragraphStyle, forKey: NSAttributedString.Key.paragraphStyle)
        }

        if lineSpace != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpace!
            attrib.updateValue(paragraphStyle, forKey: NSAttributedString.Key.paragraphStyle)
        }
        
        
        let size = CGSize(width: width, height: CGFloat(Double.greatestFiniteMagnitude))
        return ceil((self as NSString).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attrib, context: nil).height)
    }

    /// 设置颜色
    func color(_ color: UIColor) -> NSAttributedString {
        let colorString = NSMutableAttributedString(string: self, attributes: [.foregroundColor: color])
        return colorString
    }

    /// 设置子字符串的颜色
    func colorSubString(_ subString: String, color: UIColor) -> NSMutableAttributedString {
        var start = 0
        var ranges: [NSRange] = []
        while true {
            let range = (self as NSString).range(of: subString, options: NSString.CompareOptions.literal, range: NSRange(location: start, length: (self as NSString).length - start))
            if range.location == NSNotFound {
                break
            } else {
                ranges.append(range)
                start = range.location + range.length
            }
        }
        let attrText = NSMutableAttributedString(string: self)
        for range in ranges {
            attrText.addAttribute(.foregroundColor, value: color, range: range)
        }
        return attrText
    }

    /// 检查字符串是否包含Emoji
    func includesEmoji() -> Bool {
        for i in 0 ... length {
            let c: unichar = (self as NSString).character(at: i)
            if (0xD800 <= c && c <= 0xDBFF) || (0xDC00 <= c && c <= 0xDFFF) {
                return true
            }
        }
        return false
    }

    /// 添加到粘贴板
    func addToPasteboard() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = self
    }

    // url编码
    func urlEncoded() -> String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    // url编码
    mutating func urlEncode() {
        self = urlEncoded()
    }

    // url解码
    func urlDecoded() -> String {
        return removingPercentEncoding ?? self
    }

    // url解码
    mutating func urlDecode() {
        self = urlDecoded()
    }

    /// 子字符串获取
    /// eg. "Hello World".slicing(from: 6, length: 5) -> "World"
    func slicing(from index: Int, length: Int) -> String? {
        guard length >= 0, index >= 0, index < count else { return nil }
        guard index.advanced(by: length) <= count else {
            return self[safe: index ..< count]
        }
        guard length > 0 else { return "" }
        return self[safe: index ..< index.advanced(by: length)]
    }

    /// 子字符串获取
    ///
    ///        var str = "Hello World"
    ///        str.slice(from: 6, length: 5)
    ///        print(str) // prints "World"
    @discardableResult
    mutating func slice(from index: Int, length: Int) -> String {
        if let str = slicing(from: index, length: length) {
            self = String(str)
        }
        return self
    }

    /// 获取索引位置以及后面的字符串
    ///
    ///        var str = "Hello World"
    ///        str.slice(at: 6)
    ///        print(str) // prints "World"
    @discardableResult
    mutating func slice(at index: Int) -> String {
        guard index < count else { return self }
        if let str = self[safe: index ..< count] {
            self = str
        }
        return self
    }

    /// 移除前缀字符串
    ///
    ///   "Hello, World!".removingPrefix("Hello, ") -> "World!"
    func removingPrefix(_ prefix: String) -> String {
        guard hasPrefix(prefix) else { return self }
        return String(dropFirst(prefix.count))
    }

    /// 移除后缀字符串
    ///
    ///   "Hello, World!".removingSuffix(", World!") -> "Hello"
    func removingSuffix(_ suffix: String) -> String {
        guard hasSuffix(suffix) else { return self }
        return String(dropLast(suffix.count))
    }

    /// 添加前缀字符串
    ///
    ///     "www.apple.com".withPrefix("https://") -> "https://www.apple.com"
    func withPrefix(_ prefix: String) -> String {
        // https://www.hackingwithswift.com/articles/141/8-useful-swift-extensions
        guard !hasPrefix(prefix) else { return self }
        return prefix + self
    }

    /// 通过下标获取索引元素
    ///
    ///        "Hello World!"[safe: 3] -> "l"
    ///        "Hello World!"[safe: 20] -> nil
    subscript(safe index: Int) -> Character? {
        guard index >= 0 && index < count else { return nil }
        return self[self.index(startIndex, offsetBy: index)]
    }

    /// 通过下标范围获取索引元素
    ///
    ///        "Hello World!"[safe: 6..<11] -> "World"
    ///        "Hello World!"[safe: 21..<110] -> nil
    ///
    ///        "Hello World!"[safe: 6...11] -> "World!"
    ///        "Hello World!"[safe: 21...110] -> nil
    subscript<R>(safe range: R) -> String? where R: RangeExpression, R.Bound == Int {
        let range = range.relative(to: Int.min ..< Int.max)
        guard range.lowerBound >= 0,
            let lowerIndex = index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex),
            let upperIndex = index(startIndex, offsetBy: range.upperBound, limitedBy: endIndex) else {
            return nil
        }

        return String(self[lowerIndex ..< upperIndex])
    }
}

public extension String {
    init(_ value: Float, precision: Int) {
        let nFormatter = NumberFormatter()
        nFormatter.numberStyle = .decimal
        nFormatter.maximumFractionDigits = precision
        self = nFormatter.string(from: NSNumber(value: value))!
    }

    init(_ value: Double, precision: Int) {
        let nFormatter = NumberFormatter()
        nFormatter.numberStyle = .decimal
        nFormatter.maximumFractionDigits = precision
        self = nFormatter.string(from: NSNumber(value: value))!
    }
}

/// 用于switch的case语句
public func hasPrefix(_ prefix: String) -> (_ value: String) -> Bool {
    return { (value: String) -> Bool in
        value.hasPrefix(prefix)
    }
}

/// 用于switch的case语句
public func hasSuffix(_ suffix: String) -> (_ value: String) -> Bool {
    return { (value: String) -> Bool in
        value.hasSuffix(suffix)
    }
}
