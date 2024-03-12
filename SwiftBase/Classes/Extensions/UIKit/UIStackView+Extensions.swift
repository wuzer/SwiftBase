//
//  UIStackView+Extensions.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

// MARK: - Initializers

public extension UIStackView {
    /// 构造方法
    convenience init(distribution: UIStackView.Distribution,
                     alignment: UIStackView.Alignment,
                     axis: NSLayoutConstraint.Axis,
                     spacing: CGFloat = 0) {
        self.init()
        self.distribution = distribution
        self.alignment = alignment
        self.axis = axis
        self.spacing = spacing
    }

    /// eg.   let stackView = UIStackView(arrangedSubviews: [UIView(), UIView()], axis: .vertical)
    convenience init(
        arrangedSubviews: [UIView],
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat = 0.0,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
}

// MARK: - Methods

public extension UIStackView {
    /// 可同时添加多个子控件
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }

    /// 移除所有ArrangedView
    func removeArrangedSubviews() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
        }
    }

    /// 移除所有子控件
    func removeAllSubviews() {
        subviews.forEach {
            $0.removeFromSuperview()
        }
        arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }

    ///  设置背景颜色
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
