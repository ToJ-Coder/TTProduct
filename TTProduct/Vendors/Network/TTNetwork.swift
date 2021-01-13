//
//  TTNetwork.swift
//  TTProduct
//
//  Created by Toj on 1/12/21.
//

import Foundation

struct TTNetwork { }

extension TTNetwork {
    
    struct API : Hashable, Equatable, RawRepresentable {
        
        public var rawValue: String
        
        static var base: String = "http://api-test.vipcode.com/api"
        
        public static var secret: TTNetwork.API {
            return API(rawValue: "/user/secret")
        }
        
        public static var log: TTNetwork.API {
            return API(rawValue: "/user/login")
        }
    }
}

extension TTNetwork {
    
    struct Header {
        
        public var rawValue: [String:String]
        
        static var secret: TTNetwork.Header = Header(
            rawValue: ["Content-Type": "application/json",
                       "appKey": "88F0373F94FD3EA7607F886D5EA27621"])
        
        static var general: TTNetwork.Header = Header(
            rawValue: ["Content-Type" : "application/json",
                       "OS" : "2",
                       "token" : "",
                       "secret" : "",
                       "version" : ""])
    }
}

extension TTNetwork {
    
    struct Parameters {
        
        static var base: [String : Any] {
            
            var parameters: [String : String] = [:]
            parameters["OSbit"] = "64"
            parameters["platform"] = "2"
            parameters["clientVersion"] = "10.11"
            parameters["role"] = "1"
            parameters["OSName"] = "1"
            parameters["macAddr"] = "1"
            
            return parameters
        }
    }
}
