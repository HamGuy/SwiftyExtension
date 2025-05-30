//
//  JKTextView.swift
//  SwiftyExtension
//
//  Created by IronMan on 2022/1/21.
//


#if canImport(UIKit)

import UIKit
/// setNeedsDisplay调用drawRect
public class JKPlaceHolderTextView: UITextView {
    /// 占位符
    public var placeHolder: String = "" {
        didSet{
            self.setNeedsDisplay()
        }
    }
    /// 占位符的颜色
    public var placeHolderColor: UIColor = UIColor.gray {
        didSet{
            self.setNeedsDisplay()
        }
    }
    /// 富文本位置的调整
    public var placeholderOrigin: CGPoint = CGPoint(x: 5, y: 7) {
        didSet {
            self.setNeedsDisplay()
        }
    }
    /// 字体的大小
    public override var font: UIFont? {
        didSet{
            self.setNeedsDisplay()
        }
    }
    /// 文字
    public override var text: String! {
        didSet{
            self.setNeedsDisplay()
        }
    }
    /// 富文本
    public override var attributedText: NSAttributedString! {
        didSet{
            self.setNeedsDisplay()
        }
    }
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        /// 默认字号
        self.font = UIFont.systemFont(ofSize: 14)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChanged), name: UITextView.textDidChangeNotification, object: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 文字的变化
    /// - Parameter notification: NSNotification
    @objc func textDidChanged(notification: NSNotification) {
        self.setNeedsDisplay()
    }
    
    public override func draw(_ rect: CGRect) {
        if self.hasText {
            return
        }
        var newRect = CGRect()
        newRect.origin = self.placeholderOrigin
        let size = self.placeHolder.jk.rectSize(font: self.font ?? UIFont.systemFont(ofSize: 14), size: rect.size)
        newRect.size.width = size.width
        newRect.size.height = size.height
        /// 将placeHolder画在textView上
        (self.placeHolder as NSString).draw(in: newRect, withAttributes: [NSAttributedString.Key.font: self.font ?? UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor: self.placeHolderColor])
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.setNeedsDisplay()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: self)
    }
}

#elseif canImport(AppKit)
import AppKit

/// setNeedsDisplay调用drawRect
public class JKPlaceHolderTextView: NSTextView {
    /// 占位符
    public var placeHolder: String = "" {
        didSet{
            self.setNeedsDisplay(self.bounds)
        }
    }
    /// 占位符的颜色
    public var placeHolderColor: NSColor = NSColor.gray {
        didSet{
            self.setNeedsDisplay(self.bounds)
        }
    }
    /// 富文本位置的调整
    public var placeholderOrigin: CGPoint = CGPoint(x: 5, y: 7) {
        didSet {
            self.setNeedsDisplay(self.bounds)
        }
    }

    public override var font: NSFont? {
        didSet{
            self.setNeedsDisplay(self.bounds)
        }
    }
    // /// 文字
    public override var string: String {
        didSet{
            self.setNeedsDisplay(self.bounds)
        }
    }

    public override init(frame frameRect: NSRect, textContainer container: NSTextContainer?) {
        super.init(frame: frameRect, textContainer: container)
        /// 默认字号
        self.font = NSFont.systemFont(ofSize: 14)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChanged), name: NSText.didChangeNotification, object: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 文字的变化
    @objc func textDidChanged(notification: NSNotification) {
        self.setNeedsDisplay(self.bounds)
    }
    /// 重写draw方法
    public override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        if self.string.isEmpty {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: self.placeHolderColor,
                .font: self.font ?? NSFont.systemFont(ofSize: 14)
            ]
            let attributedString = NSAttributedString(string: self.placeHolder, attributes: attributes)
            attributedString.draw(at: self.placeholderOrigin)
        }
    }
}
#endif
