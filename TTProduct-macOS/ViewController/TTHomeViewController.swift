//
//  TTHomeViewController.swift
//  TTProduct
//
//  Created by Toj on 1/5/21.
//

import Cocoa
import TTCOM_macOS
import TTCoreData_macOS
import TTNetwork_macOS

class TTHomeViewController: TTViewController {
    
    var b:TTButton?
    var b2:TTButton?
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        // print(aMap)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleBar.isHidden = false
        titleBarHeight = 100
        titleBar.title = "傻BI了吧"
        
        let button = TTButton()
        b = button
        button.tt_backgroundColor = TTColor(hexColor: "112342")
        
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
        
        didTapTest2()
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
        
        TTAPIService.Request.secret { [weak self] (response)  in
            if let appSecret = response.data {
                print(appSecret)
                self?.save(appSecret: appSecret)
                self?.requestLogin()
                return
            }
        }
    }
    private func didTapTest2() {
        print(className + " : " + #function)

        // requestSecret()

        requestLogin()
    }

    private func logInfo() {
        print(className + " : " + (appSecret ?? ""))

        print(className + " : " + (token ?? ""))

        print(className + " : " + (secret ?? ""))

        print(className + " : " + (refreshToken ?? ""))

        print(className + " : " + (refreshSecret ?? ""))
    }

    private func requestLogin() {
        // jsonToObj()
        let account = "13800000001"
        let password = "000001"
        let pwdMD5Second = password.tt_md5.tt_md5
        let signature = ("1b5332a95b4943df9d83dbd1f3dd3c9f" + (account + pwdMD5Second).tt_md5).tt_md5

        var parameters = [String : Any]()
        parameters["signature"] = signature
        parameters["phoneNum"] = account
        parameters["appKey"] = "88F0373F94FD3EA7607F886D5EA27621"

        TTAPIService.Request.login(parameters) { [weak self] (response) in
            if let loginModel = response.data {
                self?.save(model: loginModel)
                self?.logInfo()
                self?.requestWork()
                return
            }
        }
    }

    private func requestWork() {
        var parameters = [String : Any]()
        parameters["pageSize"] = 10
        parameters["workType"] = 1
        parameters["page"] = 1
        TTAPIService.Request.works(parameters) { (response) in
            if let works = response.data {
                print(works.freeCodeList!.count)
                return
            }
        }
    }
}
