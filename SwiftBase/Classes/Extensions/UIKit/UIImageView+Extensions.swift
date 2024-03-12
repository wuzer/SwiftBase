//
//  UIImageView+Extensions.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Kingfisher

// MARK: - Initializers

public extension UIImageView {
    /// 构造方法
    convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, imageName: String? = nil) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        if let name = imageName {
            image = UIImage(named: name)
        }
    }

    /// 构造方法
    convenience init(x: CGFloat, y: CGFloat, imageName: String, scaleToWidth: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: 0, height: 0))
        image = UIImage(named: imageName)
        if image != nil {
            scaleImageFrameToWidth(width: scaleToWidth)
        } else {
            assertionFailure("Error: The imageName: '\(imageName)' is invalid!!!")
        }
    }

    /// 构造方法
    convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, image: UIImage) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        self.image = image
    }

    /// 构造方法
    convenience init(x: CGFloat, y: CGFloat, image: UIImage, scaleToWidth: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: 0, height: 0))
        self.image = image
        scaleImageFrameToWidth(width: scaleToWidth)
    }
}

// MARK: - Methods

public extension UIImageView {
    /// 设置图片宽度
    func scaleImageFrameToWidth(width: CGFloat) {
        guard let image = image else {
            print("Error: The image is not set yet!")
            return
        }
        let widthRatio = image.size.width / width
        let newWidth = image.size.width / widthRatio
        let newHeigth = image.size.height / widthRatio
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: newWidth, height: newHeigth)
    }

    /// 设置图片高度
    func scaleImageFrameToHeight(height: CGFloat) {
        guard let image = image else {
            print("Error: The image is not set yet!")
            return
        }
        let heightRatio = image.size.height / height
        let newHeight = image.size.height / heightRatio
        let newWidth = image.size.width / heightRatio
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: newWidth, height: newHeight)
    }

    /// 图片模糊
    func blur(withStyle style: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        addSubview(blurEffectView)
        clipsToBounds = true
    }

    /// 图片模糊
    func blurred(withStyle style: UIBlurEffect.Style = .light) -> UIImageView {
        let imgView = self
        imgView.blur(withStyle: style)
        return imgView
    }
}

// MARK: - Kingfisher

extension UIImageView {
    
    /// 设置图片
    func setImage(from urlStr: String?, placeHolderStr: String? = nil) {
        guard let urlStr = urlStr,
              let url = URL(string: urlStr) else {
            return
        }
        
        var placeHolderImage: UIImage? = nil
        if let placeHolderStr = placeHolderStr {
            placeHolderImage = UIImage(named: placeHolderStr)
        }

        kf.setImage(with: url, placeholder: placeHolderImage)
    }
}
