//
//  TTHomeViewController.swift
//  TTProduct
//
//  Created by Taurin on 1/5/21.
//

import Cocoa

class TTHomeViewController: TTViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleBar.isHidden = false
        titleBarHeight = 100
        titleBar.title = "傻BI了吧"
        let button = TTButton()
        button.tt_cursor = NSCursor.pointingHand
        button.tt_addTarget(self, action: #selector(self.didTapTest), for: .leftMouseUp)
        view.addSubview(button)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
    }
    
    @objc private func didTapTest() {
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
