//
//  TTObject.swift
//  TTCoreData
//
//  Created by Toj on 1/18/21.
//

import Foundation
import HandyJSON

#if DEBUG
public typealias Object = TTObject
#else
public typealias Object = NSObject
#endif

public protocol TTJSONCodable: HandyJSON { }

open class TTObject : NSObject {
    deinit {
        
        #if canImport(UIKit)
        let className = NSStringFromClass(self.classForCoder)
        #endif
        print(className + " : " + #function)
    }
}
