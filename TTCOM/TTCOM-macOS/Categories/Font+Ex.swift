//
//  Font+Ex.swift
//  VIPCODE-iPad
//
//  Created by Taurin on 4/26/20.
//  Copyright © 2020 韩笑. All rights reserved.
//

#if canImport(Cocoa)
import Cocoa
typealias TTFont = NSFont
#endif

#if canImport(UIKit)
import UIKit
typealias TTFont = UIFont
#endif

public enum RoundedCNWeight : String {
    case Normal
    case Bold
    case Medium
    case Light
    case ExtraLight
    case Heavy
    case Regular
}

extension TTFont {
    
    static func roundedCnFont( weight : RoundedCNWeight = .Regular, size : CGFloat) -> TTFont? {
        let name = "Resource-Han-Rounded-CN-" + weight.rawValue
        
        return TTFont(name: name, size: size)
    }
}
