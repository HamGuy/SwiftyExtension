//
//  JKClosure.swift
//  SwiftyExtension
//
//  Created by IronMan on 2021/1/12.
//

import Foundation
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)   
import AppKit
#endif

/// View的闭包
#if canImport(UIKit)
public typealias ViewClosure = ((UITapGestureRecognizer?, UIView, NSInteger) ->Void)
/// 手势的闭包
public typealias RecognizerClosure = ((UIGestureRecognizer) ->Void)
/// UIControl闭包
public typealias ControlClosure = ((UIControl) ->Void)

#elseif canImport(AppKit)
public typealias ViewClosure = ((NSClickGestureRecognizer?, NSView, NSInteger) ->Void)

public typealias ControlClosure = ((NSControl) ->Void)
#endif

