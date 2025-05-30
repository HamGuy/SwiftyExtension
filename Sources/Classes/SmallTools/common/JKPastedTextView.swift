//
//  JKPastedTextView.swift
//  SwiftyExtension
//
//  Created by 小冲冲 on 2023/10/13.
//

#if canImport(UIKit)
import UIKit

public class JKPastedTextView: UITextView {

    /// 是否正在复制
    public var isPasting = false
    
    public override func paste(_ sender: Any?) {
        super.paste(sender)
        isPasting = true
    }
}


#elseif canImport(AppKit)
import AppKit
public class JKPastedTextView: NSTextView {

    /// 是否正在复制
    public var isPasting = false
    
    public override func paste(_ sender: Any?) {
        super.paste(sender)
        isPasting = true
    }
}
#endif