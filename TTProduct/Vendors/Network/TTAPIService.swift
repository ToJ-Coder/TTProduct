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
        func general<T>(api url: TTNetwork.API,
                        model:T.Type,
                        type: TTHTTPRequestType = .post,
                        hearders:TTNetwork.Header? = nil,
                        parameters:[String: Any]? = nil,
                        completion: ((_ response:TTResponse<T>?)->())?)
        where T: Convertible {
            
            TTHTTPHelper.shared.request(api:url, model: model, hearders: hearders, parameters: parameters, completion: completion)
        }
        
        static func secret(completion:((_ response:TTResponse<String>?)->())?) {
            general(api: .secret, model: String.self, hearders: .secret, completion: completion)
        }
        
        static func login(completion: ((_ response:TTResponse<NSString>?)->())?) {
            general(api: .secret, model: NSString.self, hearders: .secret, completion: completion)
        }
    }
}

extension TTAPIService {
    
    struct Response {
        
        enum Code: NSInteger, ConvertibleEnum {
            // 服务器返回
            case success = 0
            case failed   = 1
            
            // NSError code
            case unknown   = -1
            case cancelled = -999
            case bad       = -1000
            case timeout   = -1001
            case unsupported = -1002
            case cannotFindHost = -1003
            case cannotConnectToHost = -1004
            case dataLengthExceedsMaximum = -1103
            case networkConnectionLost = -1005
            case dnsLookupFailed = -1006
            case httpTooManyRedirects = -1007
            case resourceUnavailable = -1008
            case notConnectedToInternet = -1009
            case redirectToNonExistentLocation = -1010
            case badServerResponse = -1011
            case userCancelledAuthentication = -1012
            case userAuthenticationRequired = -1013
            case zeroByteResource = -1014
            case cannotDecodeRawData = -1015
            case cannotDecodeContentData = -1016
            case cannotParseResponse = -1017
            case secureConnectionFailed = -1200
            case serverCertificateHasBadDate = -1201
            case serverCertificateUntrusted = -1202
            case serverCertificateHasUnknownRoot = -1203
            case serverCertificateNotYetValid = -1204
            case clientCertificateRejected = -1205
            case clientCertificateRequired = -1206
            case cannotLoadFromNetwork = -2000
            case downloadDecodingFailedMidStream = -3006
            case downloadDecodingFailedToComplete = -3007
        }
    }
}
