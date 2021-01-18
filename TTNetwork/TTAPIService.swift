//
//  TTAPIService.swift
//  TTProduct
//
//  Created by Toj on 1/12/21.
//

import Foundation
import KakaJSON

#if canImport(UIKit)
import TTCoreData_iOS
#endif

#if canImport(AppKit)
import TTCoreData_Mac
#endif

public struct TTAPIService { }

public extension TTAPIService {
    
    struct Request {
        
        static
        func general<T>(api url:TTRequest.API,
                        model:T.Type,
                        type:TTHTTPRequestType = .post,
                        hearders:TTRequest.Header? = nil,
                        parameters:[String: Any]? = nil,
                        prepare execute:(()->())? = nil,
                        completion:((_ response:TTResponse<T>)->())?)
        where T: TTJSONCodable {
            
            TTHTTPHelper.shared.request(api:url, model: model, hearders: hearders, parameters: parameters) { (response) in
                
                // + alert 错误/异常弹框
                if response.data == nil {
                    // alert
                    if response.message.count == 0 {
                        response.message = "数据异常, 请联系官方人员"
                    }
                }
                completion?(response)
            }
        }
        
        static
        func secret(completion:((_ response:TTResponse<String>)->())?) {
            general(api: .secret, model: String.self, hearders: .secret, completion: completion)
        }
        
        static
        func login(_ parameters:[String: Any]? = nil,
                   completion:((_ response:TTResponse<TTLoginModel>)->())?) {
            
            general(api: .login, model: TTLoginModel.self, parameters: parameters, completion: completion)
        }
        
        static
        func works(_ parameters:[String: Any]? = nil,
                   completion:((_ response:TTResponse<TTWork>)->())?) {
            
            general(api: .works, model: TTWork.self, parameters: parameters, completion: completion)
        }
    }
}
