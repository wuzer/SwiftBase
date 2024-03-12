//
//  UIDevice+Extensions.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public extension UIDevice {
    /// UUID
    class func idForVendor() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }

    /// 系统名称 iOS
    class func systemName() -> String {
        return UIDevice.current.systemName
    }

    /// 系统版本
    class func systemVersion() -> String {
        return UIDevice.current.systemVersion
    }

    /// 系统版本
    class func systemFloatVersion() -> Float {
        return (systemVersion() as NSString).floatValue
    }

    /// 设备名称
    class func deviceName() -> String {
        return UIDevice.current.name
    }

    /// 设备语言
    class func deviceLanguage() -> String {
        return Bundle.main.preferredLocalizations[0]
    }

    /// isPhone
    class func isPhone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    }

    /// isPad
    class func isPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }

    // eg. x86_64
    class func deviceModel() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)

        let machine = systemInfo.machine
        var identifier = ""
        let mirror = Mirror(reflecting: machine)

        for child in mirror.children {
            let value = child.value

            if let value = value as? Int8, value != 0 {
                identifier.append(String(UnicodeScalar(UInt8(value))))
            }
        }

        return identifier
    }
    
    // 底部高度 49
    class func haveSafeAreaBottom() -> Bool {
        if CGFloat.bottomPadding == 0 {
            return false
        }else {
            return true
        }
    }
}

// MARK: - 版本判断
public extension UIDevice {
    enum Versions: Float {
        case nine = 9.0
        case ten = 10.0
        case eleven = 11.0
        case twelve = 12.0
        case thirteen = 13.0
    }

    class func isVersion(_ version: Versions) -> Bool {
        return systemFloatVersion() >= version.rawValue && systemFloatVersion() < (version.rawValue + 1.0)
    }

    class func isVersionOrLater(_ version: Versions) -> Bool {
        return systemFloatVersion() >= version.rawValue
    }

    class func isVersionOrEarlier(_ version: Versions) -> Bool {
        return systemFloatVersion() < (version.rawValue + 1.0)
    }

    class var CURRENT_VERSION: String {
        return "\(systemFloatVersion())"
    }

    class func IS_OS_10() -> Bool {
        return isVersion(.ten)
    }

    class func IS_OS_10_OR_LATER() -> Bool {
        return isVersionOrLater(.ten)
    }

    class func IS_OS_10_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.ten)
    }
}
