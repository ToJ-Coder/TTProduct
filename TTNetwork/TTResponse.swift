//
//  TTResponse.swift
//  TTProduct
//
//  Created by Toj on 1/13/21.
//

import Foundation
import KakaJSON
import HandyJSON

#if canImport(UIKit)
import TTCoreData_iOS
#endif

#if canImport(AppKit)
import TTCoreData_macOS
#endif

extension NSObject:   TTJSONCodable { }
extension String:     TTJSONCodable { }
extension Array:      TTJSONCodable { }
extension Dictionary: TTJSONCodable { }

public class TTResponse<Element>: TTObject {
    public var code: Code = .failed
    public let data: Element? = nil
    public var message = ""
    public var traceId = ""
    
    deinit {
        #if canImport(UIKit)
        let className = NSStringFromClass(self.classForCoder)
        #endif
        print(className + " : " + #function )
    }
}

extension TTResponse {
    public enum Code: NSInteger, ConvertibleEnum {
        // 服务器返回
        case success = 0
        case failed   = 1
        case parametersFailed = 400
        
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
