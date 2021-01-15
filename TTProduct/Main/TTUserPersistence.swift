//
//  TTUserPersistence.swift
//  TTProduct
//
//  Created by Toj on 1/14/21.
//

import Foundation

//private var userInfo: TTUser?
protocol TTUserPersistence: TTPersistence { }

extension TTUserPersistence {
    
    func save(model: TTUser) {
        
    }
    
    func clearUserInfo() {
        
    }
    
    func u_clear() {
        clearUserInfo()
        clearPersistence()
    }
}

