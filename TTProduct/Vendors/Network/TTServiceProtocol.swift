//
//  TTServiceProtocol.swift
//  TTProduct
//
//  Created by Toj on 1/12/21.
//

import Foundation

enum TTHTTPRequestType {
    case get
    case post
}

protocol TTNetworkProtocol: NSObjectProtocol {
    var timeoutInterval: TimeInterval { get }
    
    func get<Key,Value>(url urlString:String, headers:[String: String]?, parameters:Dictionary<Key,Value>?, success: ((Any?)->())?, failure: ((Error)->())?) where Key: Hashable
    
    func post<Key,Value>(url urlString:String, headers:[String: String]?, parameters:Dictionary<Key,Value>?, success: ((Any?)->())?, failure: ((Error)->())?) where Key: Hashable
}
