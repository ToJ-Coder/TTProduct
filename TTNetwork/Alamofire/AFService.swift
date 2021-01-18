//
//  AFService.swift
//  TTProduct
//
//  Created by Toj on 1/15/21.
//

import Foundation
import Alamofire

#if canImport(Cocoa)
import Cocoa
#endif

#if canImport(UIKit)
import UIKit
#endif

class AFService: TTNetworkService {
    
    static let shared = AFService()
    
    private override init() {
        super.init()
        
        NetworkReachabilityManager.default?.startListening(onUpdatePerforming: { (state) in
            
        })
    }
    
    private lazy var manager: Session = {
        // JSONEncoding: 请求编码格式
        // responseJSON: 响应编码格式
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = timeoutInterval
        if #available(OSX 10.13, *) {
            configuration.waitsForConnectivity = true
        }
        return Session(configuration: configuration)
    }()
    
    override func get<Key, Value>(url urlString: String, headers: [String : String]?, parameters: Dictionary<Key, Value>?, success: ((Any?) -> ())?, failure: ((Error) -> ())?) where Key: Hashable {
        
        let newParameters = parameters as? [String : Any]
        let newHeaders = headers ?? [:]
        let aHeaders = HTTPHeaders(newHeaders)
        
        manager.request(urlString, method: .get, parameters: newParameters,encoding: JSONEncoding.default, headers: aHeaders).responseJSON { (response) in
            if let error = response.error as NSError? {
                failure?(error)
                return
            }
            success?(response.value)
        }
    }
    
    override func post<Key, Value>(url urlString: String, headers: [String : String]?, parameters: Dictionary<Key, Value>?, success: ((Any?) -> ())?, failure: ((Error) -> ())?) where Key: Hashable {
        
        let newParameters = parameters as? [String : Any]
        let newHeaders = headers ?? [:]
        let aHeaders = HTTPHeaders(newHeaders)
        
        manager.request(urlString, method: .post, parameters: newParameters,encoding: JSONEncoding.default, headers: aHeaders).responseJSON { (response) in
            if let error = response.error as NSError? {
                failure?(error)
                return
            }
            success?(response.value)
        }
    }
}
