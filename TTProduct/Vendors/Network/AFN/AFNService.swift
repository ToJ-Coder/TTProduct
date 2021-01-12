//
//  AFNService.swift
//  TTProduct
//
//  Created by Toj on 1/12/21.
//

import Cocoa
import AFNetworking

class AFNService: TTNetworkService {
    
    static let shared = AFNService()
    
    private lazy var manager: AFHTTPSessionManager = AFHTTPSessionManager()
    
    private override init() {
        super.init()
        
        // 请求序列化类型 AFHTTPRequestSerializer / AFJSONRequestSerializer
        manager.requestSerializer = AFJSONRequestSerializer()
        // 响应结果序列化类型 AFHTTPResponseSerializer / AFJSONResponseSerializer
        manager.responseSerializer = AFJSONResponseSerializer()
        
        // 安全策略
        manager.securityPolicy = AFSecurityPolicy(pinningMode: .none)
        
        // 请求超时时间
        manager.requestSerializer.timeoutInterval = 15
        
        // 网络状态
        AFNetworkReachabilityManager.shared().startMonitoring()
    }
    
    override func post<Key, Value>(url path: String, headers: [String : String]?, parameters: Dictionary<Key, Value>?, success: ((Any?) -> ())?, failure: ((Error) -> ())?) where Key : Hashable {
        
        manager.post(path, parameters: parameters, headers: nil, progress: nil) { (task, response) in
            success?(response)
        } failure: { (task, error) in
            failure?(error)
        }
    }
    
    override func get<Key, Value>(url path: String, headers: [String : String]?, parameters: Dictionary<Key, Value>?, success: ((Any?) -> ())?, failure: ((Error) -> ())?) where Key : Hashable {
        
        manager.get(path, parameters: parameters, headers: headers, progress: nil) { (task, response) in
            success?(response)
        } failure: { (task, error) in
            failure?(error)
        }
    }
}