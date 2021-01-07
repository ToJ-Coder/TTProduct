//
//  TTButton.swift
//  TTProduct
//
//  Created by Taurin on 1/5/21.
//

import Cocoa

enum TTLineStyle {
    case normal
    case strikethrough
    case underline
}

enum TTTitleAlignment {
    case top
    case left
    case bottom
    case right
}

class TTButton: NSButton {
    
    // MARK: - Properties
    // MARK: Public
    
    // 鼠标形状
    public var tt_cursor: NSCursor?
    
    public var tt_selected: Bool = false {
        didSet {
            if !tt_selected {
                t_containedStates.insert(.selected)
                return
            }
            t_containedStates.remove(.selected)
        }
    }
    
    public var tt_enabled: Bool = true {
        didSet {
            if tt_enabled {
                t_containedStates.insert(.disabled)
                return
            }
            t_containedStates.remove(.disabled)
        }
    }
    
    public var tt_enabledHighlighted: Bool = true
    public var tt_userInteractionEnabled: Bool = true
    
    public var tt_backgroundColor: NSColor? {
        set {
            if !wantsLayer { wantsLayer = true }
            layer?.backgroundColor = newValue?.cgColor
        }
        get {
            let color = layer?.backgroundColor ?? .clear
            return NSColor(cgColor: color)
        }
    }
    
    // 文字的渲染属性
    public var tt_titleAttributes: [NSAttributedString.Key : Any]?
    // 文字 与 图片间距
    public var tt_spacing: CGFloat = 0
    // 文字在图片的列序
    public var tt_titleAlignment: TTTitleAlignment = .left {
        didSet {
            needsDisplay = true
        }
    }
    // 字体
    public var tt_titleFont: NSFont? {
        set {
            t_titleAttributes[NSAttributedString.Key.font] = newValue
            needsDisplay = true
        }
        get {
            return t_titleAttributes[NSAttributedString.Key.font] as? NSFont
        }
    }
    
    // 文字是否有删除线
    public var tt_lineStyle: TTLineStyle = .normal {
        didSet {
            if .strikethrough == tt_lineStyle {
                t_titleAttributes[NSAttributedString.Key.strikethroughStyle] = 1
                t_titleAttributes[NSAttributedString.Key.underlineStyle] = 0
            }
            else if .underline == tt_lineStyle {
                t_titleAttributes[NSAttributedString.Key.strikethroughStyle] = 0
                t_titleAttributes[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.single
            }
            else {
                t_titleAttributes.removeValue(forKey: .strikethroughStyle)
                t_titleAttributes.removeValue(forKey: .underlineStyle)
            }
            needsDisplay = true
        }
    }
    
    // 文字的列序
    public var tt_alignment: NSTextAlignment = .left {
        didSet {
            t_paragraphStyle.alignment = tt_alignment
            t_titleAttributes[NSAttributedString.Key.paragraphStyle] = t_paragraphStyle
            
            needsDisplay = true
        }
    }
    
    // a... or a...b or ...a 等
    public var tt_lineBreakMode: NSLineBreakMode? {
        didSet {
            t_paragraphStyle.lineBreakMode = .byTruncatingTail
            t_titleAttributes[NSAttributedString.Key.paragraphStyle] = t_paragraphStyle
            
            needsDisplay = true
        }
    }
    
    public var tt_titleBackgroundColor: NSColor? // = .red
    {
        didSet {
            t_titleAttributes[NSAttributedString.Key.backgroundColor] = tt_titleBackgroundColor
        }
    }
    
    // MARK: ReadOnly
    
    // 当前状态
    private var tt_state: NSControl.TTState  {
        get {
            if t_containedStates.contains(.disabled) { return .disabled }
            if t_containedStates.contains(.press) { return .press }
            if t_containedStates.contains(.highlighted) { return .highlighted }
            if t_containedStates.contains(.selected) { return .selected }
            return .normal;
        }
    }
    private(set) var tt_title: String?
    private(set) var tt_titleColor: NSColor? {
        didSet {
            t_titleAttributes[NSAttributedString.Key.foregroundColor] = tt_titleColor;
        }
    }
    private(set) var tt_image: NSImage?
    private(set) var tt_backgroundImage: NSImage?
    // 文字宽高
    var tt_titleSize: CGSize {
        get {
            return boundingRectWithSize(size: CGSize(width: Int.max, height: Int.max))
        }
    }
    
    // MARK: Private
    
    private var t_trackingArea: NSTrackingArea?
    
    // 添加的所有状态
    private var t_containedStates: NSControl.TTState = .normal {
        didSet {
            self.setValueToStateAttributes(state: t_containedStates)
            needsDisplay = true
        }
    }
    
    private lazy var t_paragraphStyle: NSMutableParagraphStyle = {
        let style = NSMutableParagraphStyle()
        style.alignment = .right
        style.lineBreakMode = .byTruncatingMiddle
        
        return style
    }()
    
    // 文字的渲染属性
    private lazy var t_titleAttributes: [NSAttributedString.Key : Any] = {
        var attributes = [NSAttributedString.Key : Any]()
        attributes[NSAttributedString.Key.paragraphStyle] = t_paragraphStyle
        return attributes
    }()
    
    // 每个状态信息
    private lazy var t_stateAttributes: [NSControl.TTState.RawValue: NSMutableDictionary] = {
        var attributes: [NSControl.TTState.RawValue: NSMutableDictionary] = [:]
        
        let stateAttribute = NSMutableDictionary()
        stateAttribute[TTStateKey.titleColor] = NSColor.clear
        
        attributes[NSControl.TTState.normal.rawValue] = stateAttribute
        return attributes
    }()
    
    private lazy var tt_actions: [NSEvent.EventTypeMask.RawValue: NSMapTable<NSString, AnyObject>] = [:]
    
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        setupMakeInitialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupMakeInitialize()
    }
    
    deinit {
        print(className + " : " + #function)
    }
}

extension TTButton {
    
    override var font: NSFont? {
        didSet {
            t_titleAttributes[NSAttributedString.Key.font] = font
            
            needsDisplay = true
        }
    }
    
    override var image: NSImage? {
        set {
            tt_setImage(newValue, for: .normal)
        }
        get {
            return nil
        }
    }
    
    override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
        return true
    }
    
    /*
     STrackingMouseEnteredAndExited     = 0x01,//鼠标进入和退出
     NSTrackingMouseMoved               = 0x02,//鼠标移动
     NSTrackingCursorUpdate             = 0x04, //更新鼠标光标形状
     NSTrackingActiveWhenFirstResponder = 0x10, //第一响应者时跟踪所有事件
     NSTrackingActiveInKeyWindow        = 0x20, //应用是key Window时 跟踪所有事件
     NSTrackingActiveInActiveApp        = 0x40, //应用是激活状态时跟踪所有事件
     NSTrackingActiveAlways             = 0x80, //跟踪所有事件（鼠标进入/退出/移动)
     
     NSTrackingAssumeInside             = 0x100,
     NSTrackingInVisibleRect            = 0x200,
     NSTrackingEnabledDuringMouseDrag   = 0x400
     */
    override func updateTrackingAreas() {
        guard t_trackingArea == nil else { return }
        
        let options: NSTrackingArea.Options = [.mouseEnteredAndExited,
                                               .mouseMoved,
                                               .cursorUpdate,
                                               .activeAlways
        ]
        t_trackingArea = NSTrackingArea(rect: bounds, options: options, owner: self, userInfo: nil)
        addTrackingArea(t_trackingArea!)
    }
}


extension TTButton {
    
    // 鼠标刚进入
    override func mouseEntered(with event: NSEvent) {
        // print(className + " : " + #function)
        
        if  !tt_enabled ||
            !tt_enabledHighlighted ||
            !tt_userInteractionEnabled
        { return; }
        
        t_containedStates.insert(.highlighted)
        t_responseEvents(controlEvents: .mouseEntered)
    }
    
    // 鼠标左键按下
    override func mouseDown(with event: NSEvent) {
        // print(className + " : " + #function)
        
        if  !self.tt_enabled ||
            !self.tt_userInteractionEnabled
        { return; }
        
        t_containedStates.insert(.press)
        t_responseEvents(controlEvents: .leftMouseDown)
    }
    
    // 鼠标左键抬起
    override func mouseUp(with event: NSEvent) {
        // print(className + " : " + #function)
        
        if  !self.tt_enabled ||
            !self.tt_userInteractionEnabled
        { return; }
        
        t_containedStates.remove(.press)
        
        let locationInWindow = event.locationInWindow
        let clickLocation = convert(locationInWindow, from: nil)
        
        let isContains = bounds.contains(clickLocation)
        if !isContains { return }
        
        t_responseEvents(controlEvents: .leftMouseUp)
    }
    
    // 鼠标离开
    override func mouseExited(with event: NSEvent) {
        // print(className + " : " + #function)
        
        if  !tt_enabled ||
            !tt_enabledHighlighted ||
            !tt_userInteractionEnabled
        { return; }
        
        t_containedStates.remove(.highlighted)
        t_responseEvents(controlEvents: .mouseExited)
    }
    
    // 光标事件
    override func cursorUpdate(with event: NSEvent) {
        print(className + " : " + #function)
        
        tt_cursor?.set()
    }
    
    private func t_responseEvents(controlEvents: NSEvent.EventTypeMask) {
        guard let map = tt_actions[controlEvents.rawValue] else { return }
        
        guard let aTarget = map.object(forKey: TTEventKey.target.rawValue) else { return }
        let aAction = map.object(forKey: TTEventKey.action.rawValue) as? String ?? ""
        guard aAction.count > 0 else { return }
        
        NSApp.sendAction(Selector(aAction), to: aTarget, from: self)
    }
}

extension TTButton {
    public func tt_setTitle(_ title: String?, for state: NSControl.TTState) {
        let stateAttribute = getAttributeForState(state)
        stateAttribute[TTStateKey.title.rawValue] = title;
        
        t_containedStates = .normal;
    }
    
    public func tt_setTitleColor(_ color: String?, for state: NSControl.TTState) {
        let stateAttribute = getAttributeForState(state)
        stateAttribute[TTStateKey.titleColor.rawValue] = color;
        
        t_containedStates = .normal;
    }
    
    public func tt_setImage(_ image: NSImage?, for state: NSControl.TTState) {
        let stateAttribute = getAttributeForState(state)
        stateAttribute[TTStateKey.image.rawValue] = image;
        
        t_containedStates = .normal;
    }
    
    public func tt_setBackgroundImage(_ image: NSImage?, for state: NSControl.TTState) {
        let stateAttribute = getAttributeForState(state)
        stateAttribute[TTStateKey.backgroundImage.rawValue] = image;
        
        t_containedStates = .normal;
    }
    
    private func getAttributeForState(_ state: NSControl.TTState) -> NSMutableDictionary {
        if let stateAttribute = t_stateAttributes[state.rawValue] {
            return stateAttribute
        }
        
        let stateAttribute = NSMutableDictionary()
        t_stateAttributes[state.rawValue] = stateAttribute
        return stateAttribute
    }
    
    private func setValueToStateAttributes(state: NSControl.TTState) {
        let _state = tt_state
        
        var _stateAttribute = t_stateAttributes[_state.rawValue]
        // 如果当前状态没有值就是normal状态
        if _stateAttribute == nil {
            _stateAttribute = t_stateAttributes[NSControl.TTState.normal.rawValue]
        }
        
        var titleString = _stateAttribute?[TTStateKey.title.rawValue] as AnyObject as? String ?? ""
        if (titleString.count == 0 && _state != .normal) {
            let tmpAttribute = t_stateAttributes[NSControl.TTState.normal.rawValue]
            titleString = tmpAttribute?[TTStateKey.title.rawValue] as AnyObject as? String ?? ""
        }
        tt_title = titleString
        
        var stateColor = _stateAttribute?[TTStateKey.titleColor.rawValue] as AnyObject as? NSColor
        if (stateColor == nil && _state != .normal) {
            let tmpAttribute = t_stateAttributes[NSControl.TTState.normal.rawValue]
            stateColor = tmpAttribute?[TTStateKey.titleColor.rawValue] as AnyObject as? NSColor
        }
        tt_titleColor = stateColor
        
        var stateImage = _stateAttribute?[TTStateKey.image.rawValue] as AnyObject as? NSImage
        if (stateImage == nil && _state != .normal) {
            let tmpAttribute = t_stateAttributes[NSControl.TTState.normal.rawValue]
            stateImage = tmpAttribute?[TTStateKey.image.rawValue] as AnyObject as? NSImage
        }
        tt_image = stateImage
        
        var stateBackgroundImage = _stateAttribute?[TTStateKey.backgroundImage.rawValue] as AnyObject as? NSImage
        if (stateBackgroundImage == nil && _state != .normal) {
            let tmpAttribute = t_stateAttributes[NSControl.TTState.normal.rawValue]
            stateBackgroundImage = tmpAttribute?[TTStateKey.backgroundImage.rawValue] as AnyObject as? NSImage
        }
        tt_backgroundImage = stateBackgroundImage
    }
}

extension TTButton: TTResponderProtocol {
    public func tt_addTarget(_ target:  AnyObject?, action: Selector, for controlEvents: NSEvent.EventTypeMask) {
        
        let map = NSMapTable<NSString, AnyObject>.strongToWeakObjects()
        map.setObject(target, forKey: TTEventKey.target.rawValue)
        let aAction = NSStringFromSelector(action) as NSString
        map.setObject(aAction, forKey: TTEventKey.action.rawValue)
        
        tt_actions[controlEvents.rawValue] = map
    }
    
    public func tt_removeTarget(_ target: AnyObject?, action: Selector?, for controlEvents: NSEvent.EventTypeMask) {
        tt_actions.removeValue(forKey: controlEvents.rawValue)
    }
}

extension TTButton {
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // 容器(view)大小
        let selfWidth = bounds.size.width
        let selfHeight = bounds.size.height
        var rect = CGRect(x: 0, y: 0, width: selfWidth, height: selfHeight)
        let borderWidth = layer?.borderWidth ?? 0
        
        // 容器内部可容量大小
        let contentWidth = selfWidth - borderWidth * 2
        let contentHeight = selfHeight - borderWidth * 2
        
        // View: 背景图片
        if let t_backgroundImage = tt_backgroundImage {
            t_backgroundImage.draw(in: rect)
        }
        
        // View: title, image
        let t_title: NSString = NSString(string: tt_title ?? "")
        if tt_image == nil && t_title.length == 0 { return }
        
        // title rect
        var titleX: CGFloat = 0;
        var titleY: CGFloat = 0;
        var titleWidth: CGFloat  = 0;
        var titleHeight: CGFloat = 0;
        
        // image rect
        var imageX: CGFloat = 0;
        var imageY: CGFloat = 0;
        var imageWidth: CGFloat  = 0;
        var imageHeight: CGFloat = 0;
        
        // image size
        if let t_image = tt_image {
            let imageVWidth  = t_image.size.width;
            let imageVHeight = t_image.size.height;
            imageWidth  = imageVWidth;
            imageHeight = imageVHeight;
            if imageWidth > contentWidth {
                imageWidth = contentWidth;
                imageHeight = imageWidth * imageVHeight / imageVWidth;
            }
            
            if imageHeight > contentHeight {
                imageHeight = contentHeight;
                imageWidth = imageHeight * imageVWidth / imageVHeight;
            }
        }
        
        // 上下
        if  tt_titleAlignment == .top || tt_titleAlignment == .bottom {
            // title size
            if t_title.length > 0 {
                titleWidth = contentWidth;
                titleHeight = tt_titleSize.height;
            }
            
            // 填充最大高度
            let totalVHeight = titleHeight + imageHeight + tt_spacing;
            
            // X位置
            titleX = borderWidth
            imageX = borderWidth + (contentWidth - imageWidth) * 0.5;
            
            // Y位置
            titleY = borderWidth + (contentHeight - totalVHeight) * 0.5;
            if (titleY < 0) { titleY = borderWidth }
            imageY = titleY + titleHeight + tt_spacing;
            if tt_titleAlignment == .bottom {
                imageY = titleY;
                titleY = imageY + imageHeight + tt_spacing;
            }
        }
        
        // 左右
        if  tt_titleAlignment == .right || tt_titleAlignment == .left {
            // title size
            if t_title.length > 0 {
                // height
                titleHeight = tt_titleSize.height;
                // width
                titleWidth = tt_titleSize.width;
            }
            // 填充最大宽度
            let totalVWidth = titleWidth + tt_spacing + imageWidth;
            
            // Y位置
            imageY = borderWidth + (contentHeight - imageHeight) * 0.5
            titleY = borderWidth + (contentHeight - titleHeight) * 0.5;
            
            // X位置
            titleX = borderWidth + (contentWidth - totalVWidth) * 0.5;
            if (titleX < 0) { titleX = borderWidth }
            imageX = titleX + titleWidth + tt_spacing;
            if (tt_titleAlignment == .right) {
                imageX = titleX;
                titleX = imageX + imageWidth + tt_spacing;
            }
        }
        
        // 下面逻辑不变
        // View: title
        if (t_title.length > 0) {
            rect = NSMakeRect(titleX, titleY, titleWidth, titleHeight);
            
            if let titleAttributes = tt_titleAttributes {
                t_titleAttributes = titleAttributes
            }
            
            tt_title?.draw(in: rect, withAttributes: t_titleAttributes)
        }
        
        // View: image
        if let _ = tt_image {
            rect = NSMakeRect(imageX, imageY, imageWidth, imageHeight);
            tt_image?.draw(in: rect)
        }
    }
}


extension TTButton {
    struct TTStateKey : Hashable, Equatable, RawRepresentable {
        
        private static let TTStateTitleKey: NSString = "StateTitleKey"
        private static let TTStateTitleColorKey: NSString = "StateTitleColorKey"
        private static let TTStateImageKey: NSString = "StateImageKey"
        private static let TTStateBackgroundImageKey: NSString = "StateBackgroundImageKey"
        
        public var rawValue: NSString
        
        public static var title: NSControl.TTEventKey { return TTEventKey(rawValue: TTStateTitleKey) }
        
        public static var titleColor: NSControl.TTEventKey { return TTEventKey(rawValue: TTStateTitleColorKey) }
        
        public static var image: NSControl.TTEventKey { return TTEventKey(rawValue: TTStateImageKey) }
        
        public static var backgroundImage: NSControl.TTEventKey { return TTEventKey(rawValue: TTStateBackgroundImageKey) }
    }
}

extension TTButton {
    
    public func boundingRectWithSize(size: CGSize) -> CGSize {
        
        var attributes: [NSAttributedString.Key : Any] = [:]
        if let titleFont = tt_titleFont {
            attributes[NSAttributedString.Key.font] = titleFont
        }
        
        guard let t_title = tt_title, t_title.count > 0 else {
            return .zero
        }
        
        return t_title.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes).size
    }
}

// MARK: - 初始化参数赋值

extension TTButton {
    private func setupMakeInitialize() {
        title = ""
        cell?.isHighlighted = false
        cell?.isBordered = false
        tt_backgroundColor = .clear
        focusRingType = .none
        tt_titleFont = NSFont.systemFont(ofSize: 15)
    }
}
