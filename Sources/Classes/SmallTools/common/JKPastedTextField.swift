//
//  JKPastedTextField.swift
//  SwiftyExtension
//
//  Created by 小冲冲 on 2023/10/12.
//

#if canImport(UIKit)
import UIKit

public class JKPastedTextField: UITextField {
    /// 是否正在复制
    public var isPasting = false
    
    public override func paste(_ sender: Any?) {
        super.paste(sender)
        isPasting = true
    }
}
#elseif canImport(AppKit)
import AppKit
public class JKPastedTextField: NSTextField {
    /// 是否正在复制
    public var isPasting = false
    
    
}
#endif

