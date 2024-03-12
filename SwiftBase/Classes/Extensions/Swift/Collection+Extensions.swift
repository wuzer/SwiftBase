//
//  Collection+Extensions.swift
//  TMSwiftBase_Example
//
//  Created by Dariel on 2020/6/5.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

public extension Collection {
    
    func toData() -> Data? {
        if JSONSerialization.isValidJSONObject(self) == false {
            return nil
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: [])
            let jsonString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            if jsonString != nil {
                return jsonString?.data(using: String.Encoding.utf8.rawValue)
            }
        } catch {
            return nil
        }
        return nil
    }
}

public extension NSDictionary {
    func toData() -> Data? {
        //
        do {
            let data = try JSONSerialization.data(withJSONObject: self , options: JSONSerialization.WritingOptions())
            return data
        } catch {
            
        }
        return nil
    }
}
