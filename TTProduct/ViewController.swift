//
//  ViewController.swift
//  TTProduct
//
//  Created by Toj on 1/4/21.
//

import Cocoa

class ViewController: TTViewController {
    
    private lazy var button: NSButton = {
        let view = NSButton()
        return view
    }()
    private lazy var button2: NSButton = {
        let view = NSButton()
        return view
    }()
    private lazy var button3: NSButton = {
        let view = NSButton()
        return view
    }()
    private lazy var button4: NSButton = {
        let view = NSButton()
        return view
    }()
    private lazy var button5: NSButton = {
        let view = NSButton()
        view.target = self
        view.action = #selector(self.didTapButton2)
        view.frame = CGRect(origin: .zero, size: CGSize(width: 30, height: 30))
        return view
    }()
    private lazy var button6: NSButton = {
        let view = NSButton()
        view.target = self
        view.action = #selector(self.didTapButton2)
        view.frame = CGRect(origin: .zero, size: CGSize(width: 30, height: 30))
        return view
    }()
    
    override func loadView() {
        view = NSView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        titleBar.leftViews = [button5,button6]
        titleBar.leftMargin = 70
        
        view.addSubview(button)
        view.addSubview(button2)
        view.addSubview(button3)
        view.addSubview(button4)
        button.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom).offset(-100)
            make.left.height.width.equalTo(100)
        }
        button2.snp.makeConstraints { (make) in
            make.bottom.left.equalTo(0)
            make.height.width.equalTo(100)
        }
        button3.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(-100)
            make.height.width.equalTo(100)
        }
        button4.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(0)
            make.height.width.equalTo(100)
        }
        
        button.target = self
        button.action = #selector(self.didTapButton)
        button.wantsLayer = true
        button.layer?.backgroundColor = NSColor.red.cgColor
        button2.wantsLayer = true
        button2.layer?.backgroundColor = NSColor.green.cgColor
    }
    
    @objc private func didTapButton() {
//        print(className + " : " + #function)
        
//        let center = DistributedNotificationCenter.default()
//        center.postNotificationName(NSNotification.Name(rawValue: "ShowWindow Notification2"), object: "com.chinapyg.notification2", userInfo: nil, deliverImmediately: true)
//        return
        
        let vc = TTHomeViewController()
        let window = TTWindow(contentViewController: vc)
        window.beforeWindow = view.window
        window.styleMask = [.titled,
                            .closable,
                            .miniaturizable,
                            .resizable,
                            .fullSizeContentView]
        let rect = CGRect(x: 0, y: 0, width: 700, height: 500)
        window.setFrameOrigin(CGPoint(x: 100, y: 100))
        window.setContentSize(rect.size)
        window.makeKeyAndOrderFront(self)
    }
    
    @objc private func didTapButton2() {
        print(className + " : " + #function)
    }
}

