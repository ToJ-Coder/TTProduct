//
//  TTPersistence.swift
//  TTProduct
//
//  Created by Toj on 1/13/21.
//

import Cocoa

/// 鉴权用
private let TTAppSecretKey = "TTAppSecret"
/// 登录返回
private let TTTokenKey = "TTToken"
private let TTSecretKey = "TTSecret"
// 刷新token用
public let TTRefreshTokenKey = "TTRefreshToken"
public let TTRefreshSecretKey = "TTRefreshSecret"

// 其他
public let TTAutoLoginFlagKey = "TTAutoLoginFlag"
public let TTAccountKey = "TTAccount"
public let TTPasswordKey = "TTPassword"
public let TTAccountNameKey = "TTAccountName"
public let TTAccountHeaderKey = "TTAccountHeader"

protocol TTPersistence: NSObjectProtocol {
    associatedtype T
    
    var persistence:T? { get }
    
    func save(model: T)
    func remove(key: String)
    func clear()
}

extension TTPersistence {
    
    var persistence:String? { return nil }
    
    func save(model: String) { }
    func remove(key: String) { }
}

extension TTPersistence {
    
    var appSecret:String? {
        return UserDefaults.standard.string(forKey: TTAppSecretKey)
    }
    
    func save(appSecret: String) {
        UserDefaults.standard.set(appSecret, forKey: TTAppSecretKey)
    }
    
    func removeSecret() {
        UserDefaults.standard.removeObject(forKey: TTAppSecretKey)
    }
    
    func clear() {
        removeSecret()
    }
}
