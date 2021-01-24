//
//  NSView+Ext.swift
//  TTCOM-macOS
//
//  Created by Toj on 1/21/21.
//

import AppKit

@objc 
extension NSView {
    
    public var tt_backgroundColor: NSColor? {
        set {
            if !wantsLayer { wantsLayer = true }
            layer?.backgroundColor = newValue?.cgColor
        }
        get {
            let color = layer?.backgroundColor ?? .clear
            return NSColor(cgColor: color)
        }
    }
}
