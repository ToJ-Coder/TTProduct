//
//  TTLabel.swift
//  TTProduct
//
//  Created by Toj on 1/5/21.
//

import Cocoa

class TTLabel: NSTextField {
    
    var tt_backgroundColor: NSColor? {
        set { backgroundColor = newValue }
        get { return backgroundColor }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        setupMakeInitialize()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMakeInitialize() {
        isBordered = false
        isEditable = false
        isSelectable = false
        backgroundColor = .clear
    }
    
    deinit {
        print(self.className + " " + #function)
    }
}
