//
//  TTHTTPHelper.swift
//  TTProduct
//
//  Created by Toj on 1/12/21.
//

import Foundation
import HandyJSON

#if canImport(UIKit)
import TTCoreData_iOS
#endif

#if canImport(AppKit)
import TTCoreData_Mac
#endif

public class TTHTTPHelper: NSObject {
    
    public static let shared = TTHTTPHelper()
    var prepareExecute:(()->())?
    
    private lazy var server: TTNetworkService = AFNService.shared
//    private lazy var server: TTNetworkService = AFService.shared
    
    func request<T: TTJSONCodable>(api: TTRequest.API,
                                 model:T.Type,
                                 type: TTHTTPRequestType = .post,
                                 hearders:TTRequest.Header? = nil,
                                 parameters:[String: Any]? = nil,
                                 prepare execute:(()->())? = nil,
                                 completion: ((_ t:TTResponse<T>)->())?) {
        
        let aPrepare = execute ?? prepareExecute
        aPrepare?()
        let url = TTRequest.API.base + api.rawValue
        let aHearders = hearders == nil ? headerParameters : hearders
        var allParameters:[String: Any] = parameters ?? [:]
        allParameters.t_merge(dict: fixedParameters)
     
        server.request(url: url, request: type, headers: aHearders?.rawValue, parameters: allParameters)
        { (response) in
            
            if let json = response as? Dictionary<String, Any> {
                
                // let rModel = TTResponse<T>.tt_model(json:json)
                // let rModel = json.kj.model(TTResponse<T>.self)
                if let rModel =  JSONDeserializer<TTResponse<T>>.deserializeFrom(dict: json) {
                    completion?(rModel)
                    return
                }
            }
            
            let rModel:TTResponse<T> = TTResponse<T>()
            rModel.message = "数据异常, 请联系官方人员"
            completion?(rModel)
        } failure: { (error) in
            
            let aError = error as NSError
            let rModel:TTResponse<T> = TTResponse<T>.init()
            rModel.code = .timeout
            rModel.message = aError.domain
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

extension TTHTTPHelper {
    
    func prepareExecute(prepare:@escaping (()->())) {
        prepareExecute = prepare
    }
}


extension Dictionary {
    
    fileprivate mutating func t_merge(dict: Dictionary<Key,Value>) {
        for (key, value) in dict {
            self[key] = value
        }
    }
}
