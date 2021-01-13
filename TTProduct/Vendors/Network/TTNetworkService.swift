//
//  TTNetworkService.swift
//  TTProduct
//
//  Created by Toj on 1/12/21.
//

import Foundation

class TTNetworkService: NSObject, TTNetworkProtocol {
    
    func request(string url:String, request type: TTHTTPRequestType, headers:[String: String]?, parameters:[String: Any]?, success: ((Any?)->())?, failure: ((Error)->())?) {
        
        if type == .post {
            post(string: url, headers: headers, parameters:parameters , success: success, failure: failure)
            return
        }
        
        if type == .get {
            get(string: url, headers: headers, parameters:parameters , success: success, failure: failure)
            return
        }
    }
    
    func post<Key, Value>(string url: String, headers: [String : String]?, parameters: Dictionary<Key, Value>?, success: ((Any?) -> ())?, failure: ((Error) -> ())?) where Key : Hashable { }
    
    func get<Key, Value>(string url: String, headers: [String : String]?, parameters: Dictionary<Key, Value>?, success: ((Any?) -> ())?, failure: ((Error) -> ())?) where Key : Hashable { }
}
