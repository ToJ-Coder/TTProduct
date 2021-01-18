//
//  TTWindowController.swift
//  TTProduct
//
//  Created by Toj on 1/4/21.
//

import Cocoa

class TTWindowController: NSWindowController {

    override init(window: NSWindow?) {
        super.init(window: window)
        
        print(className + " : " + #function)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    deinit {
        print(className + " : " + #function)
    }
}
