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
    
    func post<Key,Value>(string url:String, headers:[String: String]?, parameters:Dictionary<Key,Value>?, success: ((Any?)->())?, failure: ((Error)->())?)
    
    func get<Key,Value>(string url:String, headers:[String: String]?, parameters:Dictionary<Key,Value>?, success: ((Any?)->())?, failure: ((Error)->())?)
}
