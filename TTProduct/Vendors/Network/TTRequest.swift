//
//  TTRequest.swift
//  TTProduct
//
//  Created by Toj on 1/14/21.
//

import Cocoa

public struct TTRequest { }

extension TTRequest {
    
    struct API : Hashable, Equatable, RawRepresentable {
        
        public var rawValue: String
        
        #if DEBUG
        static var base: String = "http://api-test.vipcode.com/api"
        #else
        static var base: String = "http://api.vipcode.com/api"
        #endif
        
        public static var secret: TTRequest.API {
            return API(rawValue: "/user/secret")
        }
        
        public static var login: TTRequest.API {
            return API(rawValue: "/user/login")
        }
        
        public static var works: TTRequest.API {
            return API(rawValue: "/pad/course/works/pageQueryStudentWork")
        }
    }
}

extension TTRequest {
    
    struct Header: TTPersistence {
        
        public var rawValue: [String:String]
        
        static var secret: Header =
            Header(rawValue:
                    ["Content-Type": "application/json",
                     "appKey": "1b5332a95b4943df9d83dbd1f3dd3c9f"])
        
        static var general: Header =
            Header(rawValue:
                    ["Content-Type" : "application/json",
                     "os" : "2",
                     "version" : "1.0.0"]).fixHeaders()
        
        private func fixHeaders() -> Header {
            var header = rawValue
            header["token"] = token
            header["secret"] = secret
            
            return Header(rawValue: header)
        }
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
