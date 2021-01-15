//
//  AFNService.swift
//  TTProduct
//
//  Created by Toj on 1/12/21.
//

#if os(macOS)
import Cocoa
#else
import UIKit
#endif

import AFNetworking

class AFNService: TTNetworkService {
    
    static let shared = AFNService()
    
    private lazy var manager: AFHTTPSessionManager = AFHTTPSessionManager()
    
    private override init() {
        super.init()
        
        // 请求编码格式
        // AFHTTPRequestSerializer / AFJSONRequestSerializer
        manager.requestSerializer = AFJSONRequestSerializer()
        
        // 响应编码格式
        // AFHTTPResponseSerializer / AFJSONResponseSerializer
        manager.responseSerializer = AFJSONResponseSerializer()
        
        // 安全策略
        manager.securityPolicy = AFSecurityPolicy(pinningMode: .none)
        
        // 请求超时时间
        manager.requestSerializer.timeoutInterval = timeoutInterval
        
        // 网络状态
        AFNetworkReachabilityManager.shared().startMonitoring()
    }
    
    override func get<Key, Value>(url urlString: String, headers: [String : String]?, parameters: Dictionary<Key, Value>?, success: ((Any?) -> ())?, failure: ((Error) -> ())?) where Key: Hashable {
        
        manager.get(urlString, parameters: parameters, headers: headers, progress: nil) { (task, response) in
            success?(response)
        } failure: { (task, error) in
            failure?(error)
        }
    }
    
    override func post<Key, Value>(url urlString: String, headers: [String : String]?, parameters: Dictionary<Key, Value>?, success: ((Any?) -> ())?, failure: ((Error) -> ())?) where Key: Hashable {
        
        manager.post(urlString, parameters: parameters, headers: headers, progress: nil) { (task, response) in
            success?(response)
        } failure: { (task, error) in
            failure?(error)
        }
    }
}
