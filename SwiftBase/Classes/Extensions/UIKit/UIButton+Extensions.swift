//
//  UIButton+Extension.swift
//  TMKit_Example
//
//  Created by Dariel on 2020/4/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Kingfisher

// MARK: - Properties

public extension UIButton {
    @IBInspectable
    var imageForDisabled: UIImage? {
        get {
            return image(for: .disabled)
        }
        set {
            setImage(newValue, for: .disabled)
        }
    }

    @IBInspectable
    var imageForHighlighted: UIImage? {
        get {
            return image(for: .highlighted)
        }
        set {
            setImage(newValue, for: .highlighted)
        }
    }

    @IBInspectable
    var imageForNormal: UIImage? {
        get {
            return image(for: .normal)
        }
        set {
            setImage(newValue, for: .normal)
        }
    }

    @IBInspectable
    var imageForSelected: UIImage? {
        get {
            return image(for: .selected)
        }
        set {
            setImage(newValue, for: .selected)
        }
    }

    @IBInspectable
    var titleColorForDisabled: UIColor? {
        get {
            return titleColor(for: .disabled)
        }
        set {
            setTitleColor(newValue, for: .disabled)
        }
    }

    @IBInspectable
    var titleColorForHighlighted: UIColor? {
        get {
            return titleColor(for: .highlighted)
        }
        set {
            setTitleColor(newValue, for: .highlighted)
        }
    }

    @IBInspectable
    var titleColorForNormal: UIColor? {
        get {
            return titleColor(for: .normal)
        }
        set {
            setTitleColor(newValue, for: .normal)
        }
    }

    @IBInspectable
    var titleColorForSelected: UIColor? {
        get {
            return titleColor(for: .selected)
        }
        set {
            setTitleColor(newValue, for: .selected)
        }
    }

    @IBInspectable
    var titleForDisabled: String? {
        get {
            return title(for: .disabled)
        }
        set {
            setTitle(newValue, for: .disabled)
        }
    }

    @IBInspectable
    var titleForHighlighted: String? {
        get {
            return title(for: .highlighted)
        }
        set {
            setTitle(newValue, for: .highlighted)
        }
    }

    @IBInspectable
    var titleForNormal: String? {
        get {
            return title(for: .normal)
        }
        set {
            setTitle(newValue, for: .normal)
        }
    }

    @IBInspectable
    var titleForSelected: String? {
        get {
            return title(for: .selected)
        }
        set {
            setTitle(newValue, for: .selected)
        }
    }

    private var states: [UIControl.State] {
        return [.normal, .selected, .highlighted, .disabled]
    }
}

// MARK: - Initializers

public extension UIButton {
    /// 构造方法
    convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, target: AnyObject, action: Selector) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        addTarget(target, action: action, for: UIControl.Event.touchUpInside)
    }

    /// 构造方法 最小创建40*40大小的按钮
    convenience init(image: UIImage?) {
        if let image = image {
            var btnFrame = CGRect(x: 0.0, y: 0.0, width: image.size.width, height: itemSize.height)

            if image.size.height < itemSize.height {
                btnFrame.size.height = itemSize.height
            }

            if image.size.width < itemSize.width {
                btnFrame.size.width = itemSize.width
            }

            self.init(frame: btnFrame)

            contentMode = .scaleAspectFit
            backgroundColor = UIColor.clear
            setImage(image, for: .normal)
        } else {
            self.init(frame: CGRect(x: 0, y: 0, w: 40, h: 40))
            setTitle("空图片", for: .normal)
        }
    }

    /// 构造方法 默认创建16号字号 高度40 宽度文字宽度的按钮
    convenience init(buttonTitle: NSString, titleColor: UIColor) {
        let btnSize: CGSize = buttonTitle.boundingRect(with: CGSize(width: .screenWidth, height: itemSize.height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: itemSize.Font)], context: nil).size

        var btnFrame = CGRect.zero
        btnFrame.size = CGSize(width: btnSize.width, height: itemSize.height)

        self.init(frame: btnFrame)

        contentMode = .scaleAspectFit
        setTitle(buttonTitle as String, for: .normal)
        setTitleColor(titleColor, for: .normal)
        backgroundColor = UIColor.clear
        titleLabel?.font = UIFont.systemFont(ofSize: itemSize.Font)
    }
}

// MARK: - Methods

public extension UIButton {
    /// 设置背景颜色
    func setBackgroundColor(_ color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        setBackgroundImage(colorImage, for: forState)
    }

    /// 为所有按钮状态设置image
    ///
    /// - Parameter image: UIImage.
    func setImageForAllStates(_ image: UIImage) {
        states.forEach { setImage(image, for: $0) }
    }

    /// 为所有按钮状态设置color
    ///
    /// - Parameter color: UIColor.
    func setTitleColorForAllStates(_ color: UIColor) {
        states.forEach { setTitleColor(color, for: $0) }
    }

    /// 为所有按钮状态设置title
    ///
    /// - Parameter title: title string.
    func setTitleForAllStates(_ title: String) {
        states.forEach { setTitle(title, for: $0) }
    }

    /// 图片文字居中
    /// - Parameters:
    ///   - imageAboveText: 图片是否在文字上面
    ///   - spacing: 间距
    func centerTextAndImage(imageAboveText: Bool = false, spacing: CGFloat) {
        if imageAboveText {
            guard
                let imageSize = imageView?.image?.size,
                let text = titleLabel?.text,
                let font = titleLabel?.font
            else { return }

            let titleSize = text.size(withAttributes: [.font: font])

            let titleOffset = -(imageSize.height + spacing)
            titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: titleOffset, right: 0.0)

            let imageOffset = -(titleSize.height + spacing)
            imageEdgeInsets = UIEdgeInsets(top: imageOffset, left: 0.0, bottom: 0.0, right: -titleSize.width)

            let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0
            contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
        } else {
            let insetAmount = spacing / 2
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
        }
    }
}

private var actionDictKey: Void?
public typealias ButtonAction = (UIButton) -> Void

// MARK: - Button closure Methods

public extension UIButton {
    /// btn.addTouchUpInsideAction { btn in
    ///     // ...
    /// }

    // MARK: - 属性

    // 用于保存所有事件对应的闭包
    private var actionDict: (Dictionary<String, ButtonAction>)? {
        get {
            return objc_getAssociatedObject(self, &actionDictKey) as? Dictionary<String, ButtonAction>
        }
        set {
            objc_setAssociatedObject(self, &actionDictKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    // MARK: - API

    @discardableResult
    func addTouchUpInsideAction(_ action: @escaping ButtonAction) -> UIButton {
        addButton(action: action, for: .touchUpInside)
        return self
    }

    @discardableResult
    func addTouchUpOutsideAction(_ action: @escaping ButtonAction) -> UIButton {
        addButton(action: action, for: .touchUpOutside)
        return self
    }

    @discardableResult
    func addTouchDownAction(_ action: @escaping ButtonAction) -> UIButton {
        addButton(action: action, for: .touchDown)
        return self
    }

    // ...其余事件待扩展

    // MARK: - 私有方法

    private func addButton(action: @escaping ButtonAction, for controlEvents: UIControl.Event) {
        let eventKey = String(controlEvents.rawValue)

        if var actionDict = self.actionDict {
            actionDict.updateValue(action, forKey: eventKey)
            self.actionDict = actionDict
        } else {
            actionDict = [eventKey: action]
        }

        switch controlEvents {
        case .touchUpInside:
            addTarget(self, action: #selector(touchUpInsideControlEvent), for: .touchUpInside)
        case .touchUpOutside:
            addTarget(self, action: #selector(touchUpOutsideControlEvent), for: .touchUpOutside)
        case .touchDown:
            addTarget(self, action: #selector(touchDownControlEvent), for: .touchDown)
        default:
            break
        }
    }

    // 响应事件
    @objc private func touchUpInsideControlEvent() {
        executeControlEvent(.touchUpInside)
    }

    @objc private func touchUpOutsideControlEvent() {
        executeControlEvent(.touchUpOutside)
    }

    @objc private func touchDownControlEvent() {
        executeControlEvent(.touchDown)
    }

    @objc private func executeControlEvent(_ event: UIControl.Event) {
        let eventKey = String(event.rawValue)
        if let actionDict = self.actionDict, let action = actionDict[eventKey] {
            action(self)
        }
    }
}

// MARK: - Kingfisher

extension UIButton {
    func setImage(from urlStr: String?, for state: UIControl.State, placeHolderStr: String? = nil) {

        guard let urlStr = urlStr,
            let url = URL(string: urlStr) else {
            return
        }
        var placeHolderImage: UIImage?
        if let placeHolderStr = placeHolderStr {
            placeHolderImage = UIImage(named: placeHolderStr)
        }

        kf.setImage(with: url, for: state, placeholder: placeHolderImage)
    }
}
