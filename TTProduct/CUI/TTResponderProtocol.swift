//
//  TTResponderProtocol.swift
//  TTProduct
//
//  Created by Taurin on 1/6/21.
//

import Cocoa

enum TTControlState: NSInteger {
    case normal        = 1   // 默认(常规) 0001
    case highlighted   = 2   // 进入      0010
    case press         = 4   // 按下(不放) 0100
    case disabled      = 8   // 禁用      1000
    case selected      = 16  // 选择 0001 0000
}

fileprivate let TTResponderEventTargetKey: NSString = "ResponderEventTargetKey"
fileprivate let TTResponderEventActionKey: NSString = "ResponderEventActionKey"

@objc protocol TTResponderProtocol: NSObjectProtocol {
    
    /// 将目标对象和操作方法与控件关联
    /// - parameter target: 目标对象
    /// - parameter action: 标识要调用的动作方法的选择器
    /// - parameter controlEvents: 一个位码, 特指行为触发事件, see NSEvent.EventTypeMask.
    ///
    /// - 您可以多次调用此方法来为控件配置多个目标和操作
    @objc optional func tt_addTarget(_ target: AnyObject?, action: Selector, for controlEvents: NSEvent.EventTypeMask)
}

extension TTResponderProtocol {
    var TTEventTargetKey: NSString {
        return TTResponderEventTargetKey
    }
    
    var TTEventActionKey: NSString {
        return TTResponderEventActionKey
    }
}
