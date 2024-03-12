//
//  UIAlertController+Extensions.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public extension UIAlertController {

    func show() {
        guard let keyWindow = UIApplication.shared.windows.first else {
          // 处理没有 window 的情况
          return
        }
        
        keyWindow.rootViewController?.present(self, animated: true, completion: nil)
    }
    
    static func show(title: String? = nil, message: String? = nil, okTitle: String, cancelTitle: String, submitBlock: @escaping ()->Void) {
        
        let alertVc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default) {  _ in
            submitBlock()
        }
        okAction.setValue(UIColor.COLOR_RED, forKey: "_titleTextColor")
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        cancelAction.setValue(UIColor.COLOR_BLACK_MIDDLE, forKey: "_titleTextColor")

        alertVc.addAction(okAction)
        alertVc.addAction(cancelAction)
        
        alertVc.show()
    }
}
