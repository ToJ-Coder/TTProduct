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
        
        titleBar.isHidden = false
        titleBarHeight = 100
        titleBar.title = "傻BI了吧"
        
        let button = TTButton()
        b = button
        button.tt_backgroundColor = .gray
        
        button.tt_selected = true
        button.tt_setTitle("Python", for: .normal)
        button.tt_setTitleColor(NSColor.green, for: .normal)
        button.tt_setImage(NSImage(named: "1"), for: .normal)
        
        view.addSubview(button)
        button.tt_addTarget(self, action: #selector(self.didTapTest), for: .leftMouseUp)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
    }
   
    @objc private func didTapTest() {
        print(className + " : " + #function)
        
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

extension TTHomeViewController: TTPersistence {
    
    private func requestSecret() {
        TTAPIService.Request.secret {  [weak self] (response)  in
            if let appSecret = response.data {
                self?.save(appSecret: appSecret)
                self?.requestLogin()
                return
            }
        }
    }
    
    private func requestLogin() {
        let account = "13800000001"
        let password = "000001"
        let pwdMD5Second = password.md5.md5
        let signature = (account + pwdMD5Second).md5.md5
        
        var parameters = [String : Any]()
        parameters["signature"] = signature
        parameters["phoneNum"] = account
        parameters["appKey"] = "88F0373F94FD3EA7607F886D5EA27621"
        TTAPIService.Request.login(parameters: parameters) { (response) in
            
        }
    }
}
