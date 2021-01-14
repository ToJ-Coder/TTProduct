//
//  TTAPIService.swift
//  TTProduct
//
//  Created by Toj on 1/12/21.
//

import Cocoa
import KakaJSON

struct TTAPIService { }

extension TTAPIService {
    
    struct Request {
        
        static
        func general<T>(api url:TTRequest.API,
                        model:T.Type,
                        type:TTHTTPRequestType = .post,
                        hearders:TTRequest.Header? = nil,
                        parameters:[String: Any]? = nil,
                        completion:((_ response:TTResponse<T>)->())?)
        where T: Convertible {
            
            TTHTTPHelper.shared.request(api:url, model: model, hearders: hearders, parameters: parameters) { (response) in
                
                // + alert 错误/异常弹框
                completion?(response)
            }
        }
        
        static
        func secret(completion:((_ response:TTResponse<String>)->())?) {
            general(api: .secret, model: String.self, hearders: .secret, completion: completion)
        }
        
        static
        func login(parameters:[String: Any]? = nil,
                   completion:((_ response:TTResponse<TTLoginModel>)->())?) {
            
            general(api: .login, model: TTLoginModel.self, hearders: .secret, completion: completion)
        }
    }
}
