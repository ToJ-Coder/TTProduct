//
//  TTHTTPHelper.swift
//  TTProduct
//
//  Created by Toj on 1/12/21.
//

import Foundation
import KakaJSON

public class TTHTTPHelper: NSObject {
    
    public static let shared = TTHTTPHelper()
    
    private lazy var server: TTNetworkService = AFNService.shared
    //    private lazy var server: TTNetworkService = KFService.shared
    
    func request<T:Convertible>(api: TTRequest.API,
                                model:T.Type,
                                type: TTHTTPRequestType = .post,
                                hearders:TTRequest.Header? = nil,
                                parameters:[String: Any]? = nil,
                                completion: ((_ t:TTResponse<T>)->())?) {
        
        let url = TTRequest.API.base + api.rawValue
        let aHearders = hearders == nil ? headerParameters : hearders
        var allParameters:[String: Any] = parameters ?? [:]
        allParameters.t_merge(dict: fixedParameters)
        
        server.request(string: url, request: type, headers: aHearders?.rawValue, parameters: allParameters)
        { (response) in
            
            if let json = response as? Dictionary<String, Any> {
               let rModel = json.kj.model(TTResponse<T>.self)
                completion?(rModel)
                return
            }
            
            let rModel:TTResponse<T> = TTResponse<T>()
            completion?(rModel)
        } failure: { (error) in
            
            let aError = error as NSError
            let rModel:TTResponse<T> = TTResponse<T>.init()
            rModel.code = .timeout
            rModel.message = aError.description
            completion?(rModel)
        }
    }
    
    private var headerParameters: TTRequest.Header {
        return TTRequest.Header.general
    }
    
    private var fixedParameters: [String: Any] {
        return TTRequest.Parameters.base
    }
}

extension Dictionary {
    
    fileprivate mutating func t_merge(dict: Dictionary<Key,Value>) {
        for (key, value) in dict {
            self[key] = value
        }
    }
}
