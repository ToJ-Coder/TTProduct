//
//  TTRequest.swift
//  TTProduct
//
//  Created by Toj on 1/14/21.
//

import Cocoa

struct TTRequest { }
extension TTRequest {
    
    struct API : Hashable, Equatable, RawRepresentable {
        
        public var rawValue: String
        
        static var base: String = "http://api-test.vipcode.com/api"
        
        public static var secret: API {
            return API(rawValue: "/user/secret")
        }
        
        public static var login: API {
            return API(rawValue: "/user/login")
        }
    }
}

extension TTRequest {
    
    struct Header {
        
        public var rawValue: [String:String]
        
        static var secret: TTRequest.Header = Header(
            rawValue: ["Content-Type": "application/json",
                       "appKey": "88F0373F94FD3EA7607F886D5EA27621"])
        
        static var general: TTRequest.Header = Header(
            rawValue: ["Content-Type" : "application/json",
                       "os" : "2",
                       "OS" : "2",
                       "token" : "",
                       "secret" : "",
                       "version" : ""])
    }
}

extension TTRequest {
    
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
