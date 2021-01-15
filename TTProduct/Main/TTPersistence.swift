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

protocol TTPersistence {
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
    func clear() { }
}

extension TTPersistence {
    
    var appSecret:String? {
        return UserDefaults.standard.string(forKey: TTAppSecretKey)
    }
    
    func save(appSecret: String) {
        UserDefaults.standard.set(appSecret, forKey: TTAppSecretKey)
    }
    
    var token:String? {
        return UserDefaults.standard.string(forKey: TTTokenKey)
    }
    
    var secret:String? {
        return UserDefaults.standard.string(forKey: TTSecretKey)
    }
    
    func save(refreshToken: String) {
        UserDefaults.standard.set(refreshToken, forKey: TTRefreshTokenKey)
    }
    
    var refreshToken:String? {
        return UserDefaults.standard.string(forKey: TTRefreshTokenKey)
    }
    
    func save(refreshSecret: String) {
        UserDefaults.standard.set(refreshSecret, forKey: TTRefreshSecretKey)
    }
    
    var refreshSecret:String? {
        return UserDefaults.standard.string(forKey: TTRefreshSecretKey)
    }
    
    func save(model: TTLoginModel) {
        UserDefaults.standard.set(model.token, forKey: TTTokenKey)
        UserDefaults.standard.set(model.secret, forKey: TTSecretKey)
        UserDefaults.standard.set(model.refreshToken, forKey: TTRefreshTokenKey)
        UserDefaults.standard.set(model.refreshSecret, forKey: TTRefreshSecretKey)
    }
    
    func removeSecret() {
        UserDefaults.standard.removeObject(forKey: TTAppSecretKey)
    }
    
    func removeLoginData() {
        UserDefaults.standard.removeObject(forKey: TTTokenKey)
        UserDefaults.standard.removeObject(forKey: TTSecretKey)
        UserDefaults.standard.removeObject(forKey: TTRefreshTokenKey)
        UserDefaults.standard.removeObject(forKey: TTRefreshSecretKey)
    }
    
    func clearPersistence() {
        removeLoginData()
        removeSecret()
    }
}
