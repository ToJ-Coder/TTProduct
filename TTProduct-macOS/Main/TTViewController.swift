//
//  TTViewController.swift
//  TTProduct
//
//  Created by Toj on 1/4/21.
//

import Cocoa
import SnapKit

class TTViewController: NSViewController {
    
    var titleBarHeight: CGFloat = TTTitleBar.TTDefaultHeight {
        didSet {
            setupMakeLayoutSubviews()
        }
    }
    
    lazy var titleBar: TTTitleBar = {
        let view = TTTitleBar()
        view.isHidden = true
        return view
    }()
    
    deinit {
        print(className + " : " + #function)
    }
}

extension TTViewController {
    
    override func loadView() {
        view = NSView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMakeAddSubviews()
    }
    override func updateViewConstraints() {
        super.updateViewConstraints()
        setupMakeLayoutSubviews()
    }
}

// MARK: - private
extension TTViewController {
    
}

// MARK: - setup
extension TTViewController {
    
    private func setupMakeAddSubviews() {
        view.addSubview(titleBar)
    }
    
    private func setupMakeLayoutSubviews() {
        titleBar.snp.remakeConstraints { (make) in
            make.left.right.top.equalTo(view)
            make.height.equalTo(titleBarHeight)
        }
    }
}

extension TTViewController: NSWindowDelegate {
    
    func windowWillEnterFullScreen(_ notification: Notification) {
        // print(className + " : " + #function)
        guard let window = view.window as? TTWindow else { return }
        window.tmp_isFullScreen = true
    }
    
    func windowDidEnterFullScreen(_ notification: Notification) {
        // print(className + " : " + #function)
        guard let window = view.window as? TTWindow else { return }
        window.windowDidFullScreen()
    }
    
    func windowWillExitFullScreen(_ notification: Notification) {
        // print(className + " : " + #function)
        guard let window = view.window as? TTWindow else { return }
        window.tmp_isFullScreen = false
    }
    
    func windowDidExitFullScreen(_ notification: Notification) {
        // print(className + " : " + #function)
        guard let window = view.window as? TTWindow else { return }
        window.windowDidFullScreen()
    }
    
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        // print(className + " : " + #function)
        
        return true
    }
    
    func windowWillClose(_ notification: Notification) {
        //print(className + " : " + #function)
    }
}
