//
//  TTHTTPHelper.swift
//  TTProduct
//
//  Created by Toj on 1/12/21.
//

import Cocoa
import KakaJSON

public class TTHTTPHelper: NSObject {
    
    public static let shared = TTHTTPHelper()
     
    private lazy var server: TTNetworkService = AFNService.shared
//    private lazy var server: TTNetworkService = KFService.shared
    
    func request<T>(url: TTNetwork.API, type: TTHTTPRequestType, hearders:[String: String]?, parameters:[String: Any]?, t:T, success: ((_ t:T?)->())?, failure: ((Error)->())?) where T: Convertible {
        
        let aHearders = hearders == nil ? headerParameters : hearders
        var allParameters:[String: Any] = parameters ?? [:]
        
        allParameters.merge(dict: fixedParameters)
        
        let urlString = TTNetwork.API.base + "/api" + url.rawValue
        print(allParameters)
        server.request(url: urlString, type: type, headers: aHearders, parameters: allParameters) { (response) in
         
            var model: T?
            if let json = response as? Dictionary<String, Any> {
              
                model = json.kj.model(T.self) 
                
            }
            success?(model)
        } failure: { (error) in
            
        }
    }
    
    private var headerParameters: [String: String] {
        return TTNetwork.Header.general
    }
    
    private var fixedParameters: [String: Any] {
        return TTNetwork.Parameters.base
    }
}

extension Dictionary {
    
    mutating func merge(dict: Dictionary<Key,Value>) {
        for (key, value) in dict {
            self[key] = value
        }
    }
}
