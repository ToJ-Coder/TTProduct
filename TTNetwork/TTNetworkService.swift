//
//  TTNetworkService.swift
//  TTProduct
//
//  Created by Toj on 1/12/21.
//

import Foundation

class TTNetworkService: NSObject, TTNetworkProtocol {
    var timeoutInterval: TimeInterval { return 15 }
    
    func request(url urlString:String, request type: TTHTTPRequestType, headers:[String: String]?, parameters:[String: Any]?, success: ((Any?)->())?, failure: ((Error)->())?)  {
        
        if type == .post {
            post(url: urlString, headers: headers, parameters:parameters , success: success, failure: failure)
            return
        }
        
        if type == .get {
            get(url: urlString, headers: headers, parameters:parameters , success: success, failure: failure)
            return
        }
    }
    
    func get<Key, Value>(url urlString: String, headers: [String : String]?, parameters: Dictionary<Key, Value>?, success: ((Any?) -> ())?, failure: ((Error) -> ())?) where Key: Hashable { }
    
    func post<Key, Value>(url urlString: String, headers: [String : String]?, parameters: Dictionary<Key, Value>?, success: ((Any?) -> ())?, failure: ((Error) -> ())?) where Key: Hashable { }
}
