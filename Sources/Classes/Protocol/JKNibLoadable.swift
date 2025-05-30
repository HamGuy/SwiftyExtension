//
//  NibLoadable.swift
//  JKLive
//
//  Created by 王冲 on 2020/7/23.
//  Copyright © 2020 王冲. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public protocol JKNibLoadable {
}

#if os(iOS)
// MARK: - 一、继承于UIView的才可以使用该协议的扩展
public extension JKNibLoadable where Self: UIView {
    
    // MARK: 1.1、加载xib视图
    /// 加载xib视图
    /// - Parameter nibName: xib名字
    /// - Returns: 返回视图
    static func loadFromNib(_ nibName: String? = nil) -> Self {
        let loadNme = nibName == nil ? "\(self)" : nibName!
        return Bundle.main.loadNibNamed(loadNme, owner: nil, options: nil)?.first as! Self
    }
}
#elseif os(macOS)
// MARK: - 一、继承于NSView的才可以使用该协议的扩展
public extension JKNibLoadable where Self: NSView {
    
    // MARK: 1.1、加载xib视图
    /// 加载xib视图
    /// - Parameter nibName: xib名字
    /// - Returns: 返回视图
//    static func loadFromNib(_ nibName: String? = nil) -> Self {
//        let loadNme = nibName == nil ? "\(self)" : nibName!
//        return Bundle.main.loadNibNamed(loadNme, owner: nil, topLevelObjects: nil)
//    }
}
#endif
