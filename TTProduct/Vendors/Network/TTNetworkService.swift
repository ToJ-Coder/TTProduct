//
//  TTNetworkService.swift
//  TTProduct
//
//  Created by Toj on 1/12/21.
//

import Cocoa

class TTNetworkService: NSObject, TTNetworkProtocol {
    
    func request(url path:String, type: TTHTTPRequestType, headers:[String: String]?, parameters:[String: Any]?, success: ((Any?)->())?, failure: ((Error)->())?) {
        
        if type == .post {
            post(url: path, headers: headers, parameters:parameters , success: success, failure: failure)
            return
        }
        
        if type == .get {
            get(url: path, headers: headers, parameters:parameters , success: success, failure: failure)
            return
        }
    }
    func post<Key, Value>(url path: String, headers: [String : String]?, parameters: Dictionary<Key, Value>?, success: ((Any?) -> ())?, failure: ((Error) -> ())?) where Key : Hashable { }
    
    func get<Key, Value>(url path: String, headers: [String : String]?, parameters: Dictionary<Key, Value>?, success: ((Any?) -> ())?, failure: ((Error) -> ())?) where Key : Hashable { }
}
