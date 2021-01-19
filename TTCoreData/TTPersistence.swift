//
//  TTPersistence.swift
//  TTProduct
//
//  Created by Toj on 1/13/21.
//

import Foundation

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

public protocol TTPersistence {
    associatedtype T
    
    var persistence:T? { get }
    
    func save(model: T)
    func remove(key: String)
    func clear()
}

public extension TTPersistence {
    var persistence:String? { return nil }
    func save(model: String) { }
    func remove(key: String) { }
    func clear() { }
}

extension TTPersistence {
    
    public var appSecret:String? {
        return UserDefaults.standard.string(forKey: TTAppSecretKey)
    }
    
    public func save(appSecret: String) {
        UserDefaults.standard.set(appSecret, forKey: TTAppSecretKey)
    }
    
    public var token:String? {
        return UserDefaults.standard.string(forKey: TTTokenKey)
    }
    
    public var secret:String? {
        return UserDefaults.standard.string(forKey: TTSecretKey)
    }
    
    public func save(refreshToken: String) {
        UserDefaults.standard.set(refreshToken, forKey: TTRefreshTokenKey)
    }
    
    public var refreshToken:String? {
        return UserDefaults.standard.string(forKey: TTRefreshTokenKey)
    }
    
    public func save(refreshSecret: String) {
        UserDefaults.standard.set(refreshSecret, forKey: TTRefreshSecretKey)
    }
    
    public var refreshSecret:String? {
        return UserDefaults.standard.string(forKey: TTRefreshSecretKey)
    }
    
    public func save(model: TTLoginModel) {
        UserDefaults.standard.set(model.token, forKey: TTTokenKey)
        UserDefaults.standard.set(model.secret, forKey: TTSecretKey)
        UserDefaults.standard.set(model.refreshToken, forKey: TTRefreshTokenKey)
        UserDefaults.standard.set(model.refreshSecret, forKey: TTRefreshSecretKey)
    }
    
    public func removeSecret() {
        UserDefaults.standard.removeObject(forKey: TTAppSecretKey)
    }
    
    public func removeLoginData() {
        UserDefaults.standard.removeObject(forKey: TTTokenKey)
        UserDefaults.standard.removeObject(forKey: TTSecretKey)
        UserDefaults.standard.removeObject(forKey: TTRefreshTokenKey)
        UserDefaults.standard.removeObject(forKey: TTRefreshSecretKey)
    }
    
    public func clearPersistence() {
        removeLoginData()
        removeSecret()
    }
}

