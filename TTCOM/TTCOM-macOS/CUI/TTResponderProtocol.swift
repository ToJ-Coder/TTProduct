//
//  TTResponderProtocol.swift
//  TTProduct
//
//  Created by Toj on 1/6/21.
//

import Cocoa

@objc public protocol TTResponderProtocol: NSObjectProtocol {
    
    /// 将目标对象和操作方法与控件关联
    /// - parameter target: 目标对象
    /// - parameter action: 标识要调用的动作方法的选择器
    /// - parameter controlEvents: 一个位码, 特指行为触发事件, see NSEvent.EventTypeMask.
    ///
    /// - 您可以多次调用此方法来为控件配置多个目标和操作
    @objc optional
    func tt_addTarget(_ target: AnyObject?, action: Selector, for controlEvents: NSEvent.EventTypeMask)
    
    @objc optional
    func tt_removeTarget(_ target: AnyObject?, action: Selector, for controlEvents: NSEvent.EventTypeMask)
}

private enum TTControlState: NSInteger {
    
    case normal        = 1   // 默认(常规) 0001
    case highlighted   = 2   // 进入      0010
    case press         = 4   // 按下(不放) 0100
    case disabled      = 8   // 禁用      1000
    case selected      = 16  // 选择 0001 0000
}

extension NSEvent.EventTypeMask: Hashable { }

extension NSResponder {
    
    private static let TTEventTargetKey: NSString = "ResponderEventTargetKey"
    private static let TTEventActionKey: NSString = "ResponderEventActionKey"
    
    struct TTEventKey : Hashable, Equatable, RawRepresentable {
        
        public var rawValue: NSString
        
        public static var target: NSControl.TTEventKey { return TTEventKey(rawValue: TTEventTargetKey) }
        
        public static var action: NSControl.TTEventKey { return TTEventKey(rawValue: TTEventActionKey) }
    }
}


extension NSControl {
    
    public struct TTState : OptionSet, Hashable {
        public var rawValue: UInt
        
        public init(rawValue: UInt) {
            self.rawValue = rawValue
        }
        
        public static var normal: NSControl.TTState { return TTState(rawValue: 1<<0) }
        public static var highlighted: NSControl.TTState { return TTState(rawValue: 1<<1) }
        public static var press: NSControl.TTState { return TTState(rawValue: 1<<2) }
        public static var disabled: NSControl.TTState { return TTState(rawValue: 1<<3) }
        public static var selected: NSControl.TTState { return TTState(rawValue: 1<<4) }
    }
}

extension NSObject {
    var tt: Self { return self }
}
