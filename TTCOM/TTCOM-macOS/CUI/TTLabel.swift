//
//  TTLabel.swift
//  TTProduct
//
//  Created by Toj on 1/5/21.
//

import Cocoa

open class TTLabel: NSTextField {
    
    open override var cell: NSCell? {
        set {
            super.cell = TTLabelCell()
        }
        get {
            return super.cell
        }
    }
    
    public var tt_text: String {
        set {
            stringValue = newValue
        }

        get {
            return stringValue
        }
    }
    
    public override var tt_backgroundColor: NSColor? {
        set { backgroundColor = newValue }
        get { return backgroundColor }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        t_setupMakeInitialize()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        t_setupMakeInitialize()
    }
    
    private func t_setupMakeInitialize() {
        isEditable = false
        isSelectable = false
        backgroundColor = .clear
    }
    
    deinit {
        print(self.className + " " + #function)
    }
}
