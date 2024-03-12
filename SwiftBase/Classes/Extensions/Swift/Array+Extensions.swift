//
//  Array+Extensions.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

public func == <T: Equatable>(lhs: [T]?, rhs: [T]?) -> Bool {
    switch (lhs, rhs) {
    case let (lhs?, rhs?):
        return lhs == rhs
    case (.none, .none):
        return true
    default:
        return false
    }
}

public extension Array {
    /// 创建子数组
    func get(at range: ClosedRange<Int>) -> Array {
        let halfOpenClampedRange = Range(range).clamped(to: indices)
        return Array(self[halfOpenClampedRange])
    }

    /// 元素类型判断
    func containsType<T>(of element: T) -> Bool {
        let elementType = type(of: element)
        return contains { type(of: $0) == elementType }
    }

    /// 分割数组
    func decompose() -> (head: Iterator.Element, tail: SubSequence)? {
        return (count > 0) ? (self[0], self[1 ..< count]) : nil
    }

    /// 遍历
    func forEachEnumerated(_ body: @escaping (_ offset: Int, _ element: Element) -> Void) {
        enumerated().forEach(body)
    }

    /// 通过索引获取元素
    func get(at index: Int) -> Element? {
        guard index >= 0 && index < count else { return nil }
        return self[index]
    }

    /// 插入元素到数组中
    mutating func insertFirst(_ newElement: Element) {
        insert(newElement, at: 0)
    }

    /// 获取随机元素
    func random() -> Element? {
        guard count > 0 else { return nil }
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }

    /// 索引反转
    func reverseIndex(_ index: Int) -> Int? {
        guard index >= 0 && index < count else { return nil }
        return Swift.max(count - 1 - index, 0)
    }

    /// 数组随机元素
    mutating func shuffle() {
        guard count > 1 else { return }
        var j: Int
        for i in 0 ..< (count - 2) {
            j = Int(arc4random_uniform(UInt32(count - i)))
            if i != i + j { swapAt(i, i + j) }
        }
    }

    /// 随机数组元素
    func shuffled() -> Array {
        var result = self
        result.shuffle()
        return result
    }

    /// 获取前n个元素
    func takeMax(_ n: Int) -> Array {
        return Array(self[0 ..< Swift.max(0, Swift.min(n, count))])
    }

    /// 元素判断
    func testAll(_ body: @escaping (Element) -> Bool) -> Bool {
        return !contains { !body($0) }
    }

    /// 检查元素是否为condition
    func testAll(is condition: Bool) -> Bool {
        return testAll { ($0 as? Bool) ?? !condition == condition }
    }
}

public extension Array where Element: Equatable {
    /// 是否包含array
    func contains(_ array: [Element]) -> Bool {
        return array.testAll { self.firstIndex(of: $0) ?? -1 >= 0 }
    }

    /// 是否包含多个元素
    func contains(_ elements: Element...) -> Bool {
        return elements.testAll { self.firstIndex(of: $0) ?? -1 >= 0 }
    }

    /// 返回对象索引
    func indexes(of element: Element) -> [Int] {
        return enumerated().compactMap { ($0.element == element) ? $0.offset : nil }
    }

    /// 返回对象的最后一个索引
    func lastIndex(of element: Element) -> Int? {
        return indexes(of: element).last
    }

    /// 移除第一个给定的对象
    mutating func removeFirst(_ element: Element) {
        guard let index = firstIndex(of: element) else { return }
        remove(at: index)
    }

    /// 移除所有出现的元素
    mutating func removeAll(_ firstElement: Element?, _ elements: Element...) {
        var removeAllArr = [Element]()

        if let firstElementVal = firstElement {
            removeAllArr.append(firstElementVal)
        }

        elements.forEach({ element in removeAllArr.append(element) })

        removeAll(removeAllArr)
    }

    /// 移除所有出现的元素
    mutating func removeAll(_ elements: [Element]) {
        self = filter { !elements.contains($0) }
    }

    /// 子集
    func difference(_ values: [Element]...) -> [Element] {
        var result = [Element]()
        elements: for element in self {
            for value in values {
                if value.contains(element) {
                    continue elements
                }
            }
            result.append(element)
        }
        return result
    }

    /// 插入元素数组
    func intersection(_ values: [Element]...) -> Array {
        var result = self
        var intersection = Array()

        for (i, value) in values.enumerated() {
            if i > 0 {
                result = intersection
                intersection = Array()
            }
            value.forEach { (item: Element) -> Void in
                if result.contains(item) {
                    intersection.append(item)
                }
            }
        }
        return intersection
    }

    /// 组合
    func union(_ values: [Element]...) -> Array {
        var result = self
        for array in values {
            for value in array {
                if !result.contains(value) {
                    result.append(value)
                }
            }
        }
        return result
    }

    /// 去重元素
    func unique() -> Array {
        return reduce([]) { $0.contains($1) ? $0 : $0 + [$1] }
    }
}

public extension Array where Element: Hashable {
    /// 删除所有给定元素
    mutating func removeAll(_ elements: [Element]) {
        let elementsSet = Set(elements)
        self = filter { !elementsSet.contains($0) }
    }
}

public extension Collection {
    /// 返回指定索引处的元素
    subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
