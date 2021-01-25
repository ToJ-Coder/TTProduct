//
//  Font+Ext.swift
//  VIPCODE-iPad
//
//  Created by Toj on 1/14/21.
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
    
    static func tt_roundedCnFont( weight : RoundedCNWeight = .Regular, size : CGFloat) -> TTFont? {
        let name = "Resource-Han-Rounded-CN-" + weight.rawValue
        
        return TTFont(name: name, size: size)
    }
}
