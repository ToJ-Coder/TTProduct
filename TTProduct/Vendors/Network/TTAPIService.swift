//
//  TTAPIService.swift
//  TTProduct
//
//  Created by Toj on 1/12/21.
//

import Cocoa

struct TTAPIService { }

extension TTAPIService {
    
    struct Request {
        static func secret(success: ((_ car:TTCar?)->())?) {
            
            TTHTTPHelper.shared.request(url: .secret, type: .post, hearders: TTNetwork.Header.secret, parameters: nil, t: TTCar()) { (secret) in
                print(secret?.name)
                success?(secret)
            } failure: { (error) in
                
            }
        }
        
        static  func log() {
            
//            TTHTTPHelper.shared.request(url: .log, type: .post, hearders: nil, parameters: nil, t: TTCar.self) { (car) in
//
//            } failure: { (error) in
//
//            }
        }
    }
}
