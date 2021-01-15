//
//  Color+Ex.swift
//  VIPCommon
//
//  Created by 韩笑 on 2020/5/29.
//  Copyright © 2020 VIPCODE. All rights reserved.
//

#if canImport(Cocoa)
import Cocoa
typealias TTColor = NSColor
#endif

#if canImport(UIKit)
import UIKit
typealias TTColor = UIColor
#endif

public extension TTColor {
    
    // Hex String -> UIColor
    convenience init(hexColor: String, alpha : CGFloat = 1.0) {
        let hexColor = hexColor.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexColor)
        
        if hexColor.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    // UIColor -> Hex String
    var tt_hexColor: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        let multiplier = CGFloat(255.0)
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        if alpha == 1.0 {
            return String(
                format: "#%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        }
        return String(
            format: "#%02lX%02lX%02lX%02lX",
            Int(red * multiplier),
            Int(green * multiplier),
            Int(blue * multiplier),
            Int(alpha * multiplier)
        )
    }
}
