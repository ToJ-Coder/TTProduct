//
//  TTPersistence.swift
//  TTProduct
//
//  Created by Toj on 1/13/21.
//

import Cocoa

/// 鉴权用
private let TTAppSecretKey = "TTToken"
/// 登录返回
private let TTTokenKey = "TTToken"
private let TTSecretKey = "TTToken"
// 刷新token用
public let TTRefreshTokenKey = "RefreshTokenKey"
public let TTRefreshSecretKey = "RefreshSecretKey"

// 其他
public let AutoLoginFlagKey = "AutoLoginFlagKey"
public let AccountKey = "AccountKey"
public let PasswordKey = "PasswordKey"
public let AccountNameKey = "AccountNameKey"
public let AccountHeaderKey = "AccountHeaderKey"

protocol TTPersistence: NSObjectProtocol {
    associatedtype T: NSObject
    
    var persistence:T? { get }
    
    func save(model: T)
    func remove(key: String)
    func clear()
}
