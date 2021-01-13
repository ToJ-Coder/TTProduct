//
//  KFService.swift
//  TTProduct
//
//  Created by Toj on 1/12/21.
//

#if os(macOS)
import Cocoa
#else
import UIKit
#endif

class KFService: TTNetworkService {
    
    static let shared = TTNetworkService()
    
}
