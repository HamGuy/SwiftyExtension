//
//  JKPaddingLabel.swift
//  SwiftyExtension
//
//  Created by IronMan on 2021/2/26.
//

#if canImport(UIKit)
import UIKit
// MARK: - 具有内边距的Label 
public class JKPaddingLabel : UILabel {
    
    private var padding = UIEdgeInsets.zero
    
    public var paddingLeft: CGFloat {
        get { return padding.left }
        set { padding.left = newValue }
    }
    
    public var paddingRight: CGFloat {
        get { return padding.right }
        set { padding.right = newValue }
    }
    
    public var paddingTop: CGFloat {
        get { return padding.top }
        set { padding.top = newValue }
    }
    
    public var paddingBottom: CGFloat {
        get { return padding.bottom }
        set { padding.bottom = newValue }
    }
    
    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    public override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insets = self.padding
        var rect = super.textRect(forBounds: bounds.inset(by: insets), limitedToNumberOfLines: numberOfLines)
        rect.origin.x -= insets.left
        rect.origin.y -= insets.top
        rect.size.width += (insets.left + insets.right)
        rect.size.height += (insets.top + insets.bottom)
        return rect
    }
}


#elseif canImport(AppKit)
import AppKit

public class JKPaddingLabel: NSTextField {
    
    private var padding = NSEdgeInsets.init()
    
    public var paddingLeft: CGFloat {
        get { return padding.left }
        set { padding.left = newValue }
    }
    
    public var paddingRight: CGFloat {
        get { return padding.right }
        set { padding.right = newValue }
    }
    
    public var paddingTop: CGFloat {
        get { return padding.top }
        set { padding.top = newValue }
    }
    
    public var paddingBottom: CGFloat {
        get { return padding.bottom }
        set { padding.bottom = newValue }
    }
    
    public override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect.insetBy(dx: padding.left, dy: padding.top).insetBy(dx: -padding.right, dy: -padding.bottom))
    }
}

#endif


