//
//  TTWindow.swift
//  TTProduct
//
//  Created by Toj on 1/4/21.
//

import Cocoa

class TTWindow: NSWindow {
    
    public weak var beforeWindow: NSWindow?
    // 左间距
    public var leftMargin: CGFloat = 7
    // 中间间距
    public var margin: CGFloat = 6
    // titleBar高度, 默认 22
    public var titleBarHeight: CGFloat = TTTitleBar.TTDefaultHeight {
        didSet {
            guard let vc = contentViewController as? TTViewController else { return }
            vc.titleBarHeight = titleBarHeight
        }
    }
    
    // 关闭按钮
    private lazy var closeButton: NSButton? = standardWindowButton(.closeButton)
    public var tt_isHiddenClose = false {
        didSet {
            closeButton?.isHidden = tt_isHiddenClose
        }
    }
    
    // 最小化按钮
    private lazy var miniaturizeButton: NSButton? = standardWindowButton(.miniaturizeButton)
    public var tt_isHiddenMin = true {
        didSet {
            miniaturizeButton?.isHidden = tt_isHiddenMin
        }
    }
    
    // 最大化按钮
    private lazy var zoomButton: NSButton? = standardWindowButton(.zoomButton)
    public var tt_isHiddenZoom = true {
        didSet {
            zoomButton?.isHidden = tt_isHiddenZoom
        }
    }
    
    // 隐藏title bar
    public var isHiddenTitleBar = true {
        didSet {
            let visibility: TitleVisibility = isHiddenTitleBar ? .hidden : .visible
            titleVisibility = visibility
            // / 标题栏透明，但还占着位置
            titlebarAppearsTransparent = isHiddenTitleBar
        }
    }
    
    var tmp_isFullScreen: Bool = false
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
        
        setupMakeWindow()
    }
    
    deinit {
        print(className + " : " + #function)
    }
}

extension TTWindow {
    
    override var title: String {
        get { return super.title }
        set {
            var tValue = newValue
            if  tValue == "未命名" ||
                    tValue == "Untitled"
            { tValue = "" }
            
            super.title = tValue
        }
    }
    
    override var styleMask: NSWindow.StyleMask {
        get { super.styleMask }
        set {
            let style = newValue
            if tt_isHiddenZoom && !style.contains(.resizable) { tt_isHiddenZoom = true }
            if !tt_isHiddenClose && !style.contains(.closable) { tt_isHiddenClose = true }
            if tt_isHiddenMin && !style.contains(.miniaturizable) { tt_isHiddenMin = true }
            super.styleMask = style
        }
    }
    
    override func setContentSize(_ size: NSSize) {
        super.setContentSize(size)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
    
    override func makeKeyAndOrderFront(_ sender: Any?) {
        super.makeKeyAndOrderFront(sender)
        if let vc = contentViewController as? TTViewController, delegate == nil {
            delegate = vc
        }
        setupMakeLayoutTitlebar()
    }
    
//    override func toggleFullScreen(_ sender: Any?) {
//        super.toggleFullScreen(sender)
//        print(className + " : " + #function)
//        setupMakeLayoutTitlebar()
//    }
}

extension TTWindow {
    
    func windowDidFullScreen() {
        setupMakeLayoutTitlebar()
    }
    
    private func setupMakeWindow() {
        // 设置窗口阴影
        hasShadow = true
        isOpaque = false
        
        // 窗口是否可以通过点击背景移动
        isMovableByWindowBackground = true
        isHiddenTitleBar = true
        
        styleMask = [.titled, .closable,
                     .miniaturizable, .resizable,
                     .fullSizeContentView]
    }

    private func setupMakeLayoutTitlebar() {
        print(#function)
        let windowFrame = frame
        var t_titleBarHeight = titleBarHeight
        if (tmp_isFullScreen) {
            t_titleBarHeight = TTTitleBar.TTDefaultHeight
        }
        // titlebarContainerView
        if let titlebarContainerView = miniaturizeButton?.superview?.superview {
            var titlebarFrame = titlebarContainerView.frame
            titlebarFrame.origin.y = windowFrame.size.height - t_titleBarHeight
            titlebarFrame.size.height = t_titleBarHeight
            titlebarContainerView.frame = titlebarFrame
        }
        
        // buttons
        var buttons: [NSView] = []
        if let closeButton = closeButton { buttons.append(closeButton) }
        if let minButton = miniaturizeButton { buttons.append(minButton) }
        if let zoomButton = zoomButton { buttons.append(zoomButton) }
        
        var x: CGFloat = leftMargin
        buttons.forEach { (view) in
            var viewFrame = view.frame
            viewFrame.origin.x = x
            viewFrame.origin.y = (t_titleBarHeight - viewFrame.size.height) * 0.5
            view.frame = viewFrame
            x += margin + viewFrame.size.width
        }
    }
}
