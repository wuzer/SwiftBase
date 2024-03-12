//
//  UserDefaults+Extensions.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

public extension UserDefaults {
    /// 通过下标使用枚举
    subscript<T: RawRepresentable>(key: String) -> T? {
        get {
            if let rawValue = value(forKey: key) as? T.RawValue {
                return T(rawValue: rawValue)
            }
            return nil
        }
        set { set(newValue?.rawValue, forKey: key) }
    }

    subscript<T>(key: String) -> T? {
        get { return value(forKey: key) as? T }
        set { set(newValue, forKey: key) }
    }
}

/*
 eg.
 struct Preference {
    /// bool
    static var isFirstLogin: Bool {
        get { return UserDefaults.standard[#function] ?? false }
        set { UserDefaults.standard[#function] = newValue }
    }
    /// enum
    static var appTheme: Theme {
        get { return UserDefaults.standard[#function] ?? .light }
        set { UserDefaults.standard[#function] = newValue }
    }
    /// 测试服跟正式服之间的切换（默认正式服）
    static var serverUrl: ServerUrlType {
        get { return UserDefaults.standard[#function] ?? .distributeServer }
        set { UserDefaults.standard[#function] = newValue }
    }
 }
 enum Theme: Int {
    case light
    case dark
    case blue
 }
 enum ServerUrlType: String {
    case developServer = "url: developServer" // 测试服
    case distributeServer = "url: distributeServer" // 正式服
 }
 */

/*

 // 存储数据
 Preference.isFirstLogin = true
 Preference.appTheme = .dark
 Preference.serverUrl = .developServer

 // 读取数据
 Preference.isFirstLogin // true
 Preference.appTheme == .dark // true
 Preference.serverUrl.rawValue // url: developServer

 */
