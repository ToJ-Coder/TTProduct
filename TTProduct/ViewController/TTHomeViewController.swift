//
//  TTHomeViewController.swift
//  TTProduct
//
//  Created by Toj on 1/5/21.
//

import Cocoa

class TTHomeViewController: TTViewController {

    var b:TTButton?
    var b2:TTButton?
    
//    var aMap:NSMapTable<NSString, AnyObject>?
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
//        print(aMap)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        TTAPIService.Request.self loadding {
//
//        } loaded {
//
//        }
        
        titleBar.isHidden = false
        titleBarHeight = 100
        titleBar.title = "傻BI了吧"
        
        let button = TTButton()
        b = button
        button.tt_selected = true
        button.tt_setTitle("Python", for: .normal)
        button.tt_setTitleColor(NSColor.green, for: .normal)
        button.tt_setImage(NSImage(named: "1"), for: .normal)
        
        // button.tt_titleAlignment = .right
        // button.tt_lineStyle = .underline
        // button.tt_lineBreakMode = .byTruncatingHead
//        button.tt_spacing = 4
        button.tt_backgroundColor = .gray
//        button.tt_cursor = NSCursor.pointingHand
        view.addSubview(button)
        button.tt_addTarget(self, action: #selector(self.didTapTest), for: .leftMouseUp)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
    }
    
    @objc private func didTapTest() {
        print(className + " : " + #function)
        
        TTAPIService.Request.secret { (car) in
            
        }
    }
    
    @objc private func didTapTest2() {
        print(className + " : " + #function)
        
    }
    
    override func windowShouldClose(_ sender: NSWindow) -> Bool {
        let windows = NSApp.windows
        for i in 0..<windows.count {
            let window = windows[i]
            if window.contentViewController is ViewController {
                window.makeKeyAndOrderFront(self)
                continue
            }
            window.close()
        }
        return true
    }
}
