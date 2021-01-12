//
//  TTObject.swift
//  TTProduct
//
//  Created by Toj on 1/12/21.
//

import Cocoa
import KakaJSON

class TTResponse<Element>: Convertible {
    required init() {}
    let data: Element? = nil
    let msg: String = ""
    private(set) var code: Int = 0
}

class TTObject: Convertible {
    required init() {}
    
//    var code = 0
//    var data = ""
//    var message = ""
//    var timestamp = ""
}
