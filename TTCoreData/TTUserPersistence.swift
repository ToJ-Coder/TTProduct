//
//  TTUserPersistence.swift
//  TTProduct
//
//  Created by Toj on 1/14/21.
//

import Foundation

private var userInfo: TTUser?
public protocol TTUserPersistence: TTPersistence { }

extension TTUserPersistence {
    
    public func save(model: TTUser) {
        userInfo = model
    }
    
    public func clearUserInfo() {
        
    }
    
    public func u_clear() {
        clearUserInfo()
        clearPersistence()
    }
}

