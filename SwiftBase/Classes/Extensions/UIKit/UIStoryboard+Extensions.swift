//
//  UIStoryboard+Extensions.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public extension UIStoryboard {
    ///  加载主storyboard let storyboard = UIStoryboard.mainStoryboard
    static var mainStoryboard: UIStoryboard? {
        let bundle = Bundle.main
        guard let name = bundle.object(forInfoDictionaryKey: "UIMainStoryboardFile") as? String else {
            return nil
        }
        return UIStoryboard(name: name, bundle: bundle)
    }

    /// eg. let profileVC = storyboard!.instantiateViewController(ProfileViewController)
    func instantiateViewController<T>(_ identifier: T.Type) -> T? {
        let storyboardID = String(describing: identifier)
        if let vc = instantiateViewController(withIdentifier: storyboardID) as? T {
            return vc
        } else {
            return nil
        }
    }
}
