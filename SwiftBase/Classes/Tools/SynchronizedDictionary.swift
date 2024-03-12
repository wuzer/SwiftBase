//
//  SynchronizedDictionary.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

public class SynchronizedDictionary <Key: Hashable, Value> {
    
    fileprivate let queue = DispatchQueue(label: "SynchronizedDictionary", attributes: .concurrent)
    fileprivate var dict = [Key: Value]()
    
    public func getValue(for key: Key) -> Value? {
        var value: Value?
        queue.sync {
            value = dict[key]
        }
        return value
    }
    
    public func setValue(for key: Key, value: Value) {
        queue.sync {
            dict[key] = value
        }
    }
    
    public func getSize() -> Int {
        return dict.count
    }
    
    public func containValue(for key: Key) -> Bool {
        return dict.has(key)
    }
}
