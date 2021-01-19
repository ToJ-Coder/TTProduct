//
//  TTLoginViewController.swift
//  TTProduct
//
//  Created by Toj on 1/5/21.
//

import Cocoa

class TTLoginViewController: TTViewController {
    
    private lazy var button: NSButton = {
        let view = NSButton()
        return view
    }()
    
    override func loadView() {
        view = NSView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(button)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button.target = self
        button.action = #selector(self.didTapButton)
        button.wantsLayer = true
        button.layer?.backgroundColor = NSColor.green.cgColor
    }
    
    @objc private func didTapButton() {
        print(className + " : " + #function)
        
        let vc = TTHomeViewController()
        let window = TTWindow(contentViewController: vc)
        window.beforeWindow = view.window
        window.styleMask = [.titled,
                            .closable,
                            .miniaturizable,
                            .resizable,
                            .fullSizeContentView]
        let rect = CGRect(x: 0, y: 0, width: 700, height: 500)
        window.setContentSize(rect.size)
        window.titleBarHeight = 70
        window.setFrameOrigin(CGPoint(x: 100, y: 100))
        window.makeKeyAndOrderFront(self)
    }
    
    override func windowWillClose(_ notification: Notification) {
        
        guard let window = view.window as? TTWindow else { return }
        window.beforeWindow?.windowController?.showWindow(self)
    }
}
