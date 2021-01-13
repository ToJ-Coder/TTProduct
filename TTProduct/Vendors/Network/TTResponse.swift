//
//  TTResponse.swift
//  TTProduct
//
//  Created by Toj on 1/13/21.
//

import Foundation
import KakaJSON

class TTResponse<Element>: NSObject {
    var code: TTAPIService.Response.Code = .failed
    let data: Element? = nil
    var message = ""
    var traceId = ""
    
    deinit {
        print(className + " : " + #function )
    }
}

extension String: Convertible { }
extension Array: Convertible { }
extension Dictionary: Convertible { }
extension NSObject: Convertible { }
