//
//  TTButton.swift
//  TTProduct
//
//  Created by Toj on 1/5/21.
//

import Cocoa

public enum TTLineStyle {
    case normal
    case strikethrough
    case underline
}

public enum TTTitleAlignment {
    case top
    case left
    case bottom
    case right
}

// MARK: - Class Properties
open class TTButton: NSButton {
    
    // MARK: Public
    
    // 鼠标形状
    public var tt_cursor: NSCursor?
    
    public var tt_selected: Bool = false {
        didSet {
            if tt_selected {
                t_insertedStates.insert(.selected)
                return
            }
            t_insertedStates.remove(.selected)
        }
    }
    
    public var tt_enabled: Bool = true {
        didSet {
            if !tt_enabled {
                t_insertedStates.insert(.disabled)
                return
            }
            t_insertedStates.remove(.disabled)
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
    
    /// 文字的渲染属性
    /// 设置后, 下面属性无效
    /// tt_titleFont, tt_lineStyle, tt_lineStyle, tt_alignment
    /// tt_lineBreakMode, tt_titleBackgroundColor, tt_titleColor, font
    /// 因为他会替换 私有属性 t_titleAttributes 值
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
        didSet {
            t_titleAttributes[NSAttributedString.Key.font] = tt_titleFont
            needsDisplay = true
        }
    }
    
    /// 文字是否有删除线
    public var tt_lineStyle: TTLineStyle = .normal {
        didSet {
            if .strikethrough == tt_lineStyle {
                t_titleAttributes[NSAttributedString.Key.strikethroughStyle] = 1
                t_titleAttributes[NSAttributedString.Key.underlineStyle] = 0
            }
            else if .underline == tt_lineStyle {
                t_titleAttributes[NSAttributedString.Key.strikethroughStyle] = 0
                t_titleAttributes[NSAttributedString.Key.underlineStyle] = 1
            }
            else {
                t_titleAttributes.removeValue(forKey: .strikethroughStyle)
                t_titleAttributes.removeValue(forKey: .underlineStyle)
            }
            needsDisplay = true
        }
    }
    
    // 文字的列序
    public var tt_alignment: NSTextAlignment = .center {
        didSet {
            t_paragraphStyle.alignment = tt_alignment
            needsDisplay = true
        }
    }
    
    // a... or a...b or ...a 等
    public var tt_lineBreakMode: NSLineBreakMode? {
        didSet {
            t_paragraphStyle.lineBreakMode = .byTruncatingTail
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
    private(set) var tt_state: NSControl.TTState = .normal
    private(set) var tt_title: String = ""
    private(set) var tt_titleColor: NSColor? {
        didSet {
            t_titleAttributes[NSAttributedString.Key.foregroundColor] = tt_titleColor
        }
    }
    private(set) var tt_image: NSImage?
    private(set) var tt_backgroundImage: NSImage?
    // 文字宽高
    public var tt_titleSize: CGSize {
        get {
            return t_boundingRectWithSize(size: CGSize(width: Int.max, height: Int.max))
        }
    }
    
    // MARK: Private
    
    private var t_trackingArea: NSTrackingArea?
    
    // 添加的所有状态
    private var t_insertedStates: NSControl.TTState = .normal {
        didSet {
            tt_state = t_currentState()
            t_setAttributes()
            needsDisplay = true
        }
    }
    
    private lazy var t_paragraphStyle: NSMutableParagraphStyle = {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
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
    private lazy var t_stateAttributes: [NSControl.TTState: NSMutableDictionary] = {
        var attributes: [NSControl.TTState: NSMutableDictionary] = [:]
        
        let stateAttribute = NSMutableDictionary()
        stateAttribute[TTStateKey.titleColor] = NSColor.clear
        
        attributes[NSControl.TTState.normal] = stateAttribute
        return attributes
    }()
    
    private lazy var t_maskEvents: [NSEvent.EventTypeMask: NSMapTable<NSString, AnyObject>] = [:]
    private lazy var t_actions: NSHashTable = NSHashTable<AnyObject>()
    
    // MARK: Cycle
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        t_setupMakeInitialize()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        t_setupMakeInitialize()
    }
    
    open func tt_setTitle(_ title: String?, for state: NSControl.TTState) {
        let aStateAttribute = t_attributeForState(state)
        aStateAttribute[TTStateKey.title] = title
        
        t_insertedStates.insert(.normal)
    }
    
    open func tt_setTitleColor(_ color: NSColor?, for state: NSControl.TTState) {
        let aStateAttribute = t_attributeForState(state)
        aStateAttribute[TTStateKey.titleColor] = color
        
        t_insertedStates.insert(.normal)
    }
    
    open func tt_setImage(_ image: NSImage?, for state: NSControl.TTState) {
        let aStateAttribute = t_attributeForState(state)
        aStateAttribute[TTStateKey.image] = image
        
        t_insertedStates.insert(.normal)
    }
    
    open func tt_setBackgroundImage(_ image: NSImage?, for state: NSControl.TTState) {
        let aStateAttribute = t_attributeForState(state)
        aStateAttribute[TTStateKey.backgroundImage] = image
        
        t_insertedStates.insert(.normal)
    }
    
    deinit {
        print(className + " : " + #function)
    }
}

// MARK: - Class Override Function

extension TTButton {
    
    public override var font: NSFont? {
        didSet {
            t_titleAttributes[NSAttributedString.Key.font] = font
            
            needsDisplay = true
        }
    }
    
    public override var title: String {
        set {
            tt_setTitle(newValue, for: .normal)
        }
        get {
            return tt_title
        }
    }
    
    public override var image: NSImage? {
        set {
            tt_setImage(newValue, for: .normal)
        }
        get {
            return tt_image
        }
    }
    
    public override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
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
    public override func updateTrackingAreas() {
        guard t_trackingArea == nil else { return }
        
        let aOptions: NSTrackingArea.Options = [.mouseEnteredAndExited,
                                                .mouseMoved,
                                                .cursorUpdate,
                                                .activeAlways
        ]
        t_trackingArea = NSTrackingArea(rect: bounds, options: aOptions, owner: self, userInfo: nil)
        addTrackingArea(t_trackingArea!)
    }
}

// MARK: - Class Override Event
extension TTButton {
    
    // 鼠标刚进入
    public override func mouseEntered(with event: NSEvent) {
        // print(className + " : " + #function)
        
        if !tt_enabled || !tt_enabledHighlighted || !tt_userInteractionEnabled
        { return }
        
        t_insertedStates.insert(.highlighted)
        t_responseEvents(controlEvents: .mouseEntered)
    }
    
    // 鼠标左键按下
    public override func mouseDown(with event: NSEvent) {
        // print(className + " : " + #function)
        
        if  !self.tt_enabled || !self.tt_userInteractionEnabled
        { return }
        
        t_insertedStates.insert(.press)
        t_responseEvents(controlEvents: .leftMouseDown)
    }
    
    // 鼠标左键抬起
    public override func mouseUp(with event: NSEvent) {
        // print(className + " : " + #function)
        
        if !self.tt_enabled || !self.tt_userInteractionEnabled
        { return }
        
        t_insertedStates.remove(.press)
        
        let aLocationInWindow = event.locationInWindow
        let aClickLocation = convert(aLocationInWindow, from: nil)
        
        let aIsContains = bounds.contains(aClickLocation)
        if !aIsContains { return }
        
        t_responseEvents(controlEvents: .leftMouseUp)
    }
    
    // 鼠标离开
    public override func mouseExited(with event: NSEvent) {
        // print(className + " : " + #function)
        
        if !tt_enabled || !tt_enabledHighlighted || !tt_userInteractionEnabled
        { return }
        
        t_insertedStates.remove(.highlighted)
        t_responseEvents(controlEvents: .mouseExited)
    }
    
    // 光标事件
    public override func cursorUpdate(with event: NSEvent) {
        // print(className + " : " + #function)
        
        tt_cursor?.set()
    }
    
    private func t_responseEvents(controlEvents: NSEvent.EventTypeMask) {
        
        guard let aMap = t_maskEvents[controlEvents] else { return }
        guard let aTarget = aMap.object(forKey: TTEventKey.target.rawValue) else { return }
        let aAction = aMap.object(forKey: TTEventKey.action.rawValue) as? String ?? ""
        guard aAction.count > 0 else { return }
        
        NSApp.sendAction(Selector(aAction), to: aTarget, from: self)
    }
}

extension TTButton {
    
    private func t_attributeForState(_ state: NSControl.TTState) -> NSMutableDictionary {
        if let stateAttribute = t_stateAttributes[state] {
            return stateAttribute
        }
        
        let aStateAttribute = NSMutableDictionary()
        t_stateAttributes[state] = aStateAttribute
        return aStateAttribute
    }
    
    private func t_currentState() -> NSControl.TTState {
        var aState: NSControl.TTState = .normal
        if t_insertedStates.contains(.disabled)
        { aState = .disabled }
        else if t_insertedStates.contains(.press)
        { aState = .press }
        else if t_insertedStates.contains(.highlighted)
        { aState = .highlighted }
        else if t_insertedStates.contains(.selected)
        { aState = .selected }
        return aState
    }
    
    // 当前状态对应的值, 如果没有就取nomal
    private func t_setAttributes() {
        let aState = tt_state
        let aDefAttributes: NSMutableDictionary? = t_stateAttributes[NSControl.TTState.normal]
        
        // 当前状态对应值
        // 如果没有值就是normal状态
        let aStateAttribute = t_stateAttributes[aState] ?? aDefAttributes
        
        var aTitleString = aStateAttribute?[TTStateKey.title]
        if (aTitleString == nil && aState != .normal) {
            aTitleString = aDefAttributes?[TTStateKey.title]
        }
        tt_title = aTitleString as? String ?? ""
        
        var aStateColor = aStateAttribute?[TTStateKey.titleColor]
        if (aStateColor == nil && aState != .normal) {
            aStateColor = aDefAttributes?[TTStateKey.titleColor]
        }
        tt_titleColor = aStateColor as? NSColor
        
        var aStateImage = aStateAttribute?[TTStateKey.image]
        if (aStateImage == nil && aState != .normal) {
            aStateImage = aDefAttributes?[TTStateKey.image]
        }
        tt_image = aStateImage as? NSImage
        
        var aStateBackgroundImage = aStateAttribute?[TTStateKey.backgroundImage]
        if (aStateBackgroundImage == nil && aState != .normal) {
            aStateBackgroundImage = aDefAttributes?[TTStateKey.backgroundImage]
        }
        tt_backgroundImage = aStateBackgroundImage as? NSImage
    }
}

// MARK: - Class implementation Public Function
// MARK: TTResponderProtocol
extension TTButton: TTResponderProtocol {
    
    public func tt_addTarget(_ target:  AnyObject?, action: Selector, for controlEvents: NSEvent.EventTypeMask) {
        
        let aMap = NSMapTable<NSString, AnyObject>.strongToWeakObjects()
        aMap.setObject(target, forKey: TTEventKey.target.rawValue)
        let aAction = NSString(string: String(_sel: action))
        aMap.setObject(aAction, forKey: TTEventKey.action.rawValue)
        
        t_actions.add(aAction)
        t_maskEvents[controlEvents] = aMap
    }
    
    public func tt_removeTarget(_ target: AnyObject?, action: Selector, for controlEvents: NSEvent.EventTypeMask) {
        t_maskEvents.removeValue(forKey: controlEvents)
        let aAction = NSString(string: String(_sel: action))
        t_actions.remove(aAction)
    }
}

// MARK: - Class draw Function

extension TTButton {
    public override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // 容器(view)大小
        let aSelfWidth = bounds.size.width
        let aSelfHeight = bounds.size.height
        var aRect = CGRect(x: 0, y: 0, width: aSelfWidth, height: aSelfHeight)
        let aBorderWidth = layer?.borderWidth ?? 0
        
        // 容器内部可容量大小
        let aContentWidth = aSelfWidth - aBorderWidth * 2
        let aContentHeight = aSelfHeight - aBorderWidth * 2
        
        // View: 背景图片
        if let aBackgroundImage = tt_backgroundImage {
            aBackgroundImage.draw(in: aRect)
        }
        
        // View: title, image
        if tt_title.count == 0 && tt_image == nil { return }
        
        // title rect
        var aTitleX: CGFloat = 0
        var aTitleY: CGFloat = 0
        var aTitleWidth: CGFloat  = 0
        var aTitleHeight: CGFloat = 0
        
        // image rect
        var aImageX: CGFloat = 0
        var aImageY: CGFloat = 0
        var aImageWidth: CGFloat  = 0
        var aImageHeight: CGFloat = 0
        
        // image size 太大等比例缩放
        if let aImage = tt_image {
            let aImageVWidth  = aImage.size.width
            let aImageVHeight = aImage.size.height
            aImageWidth  = aImageVWidth
            aImageHeight = aImageVHeight
            if  aImageWidth > aContentWidth {
                aImageWidth = aContentWidth
                aImageHeight = aImageWidth * aImageVHeight / aImageVWidth
            }
            
            if  aImageHeight > aContentHeight {
                aImageHeight = aContentHeight
                aImageWidth = aImageHeight * aImageVWidth / aImageVHeight
            }
        }
        
        // 上下
        if  tt_titleAlignment == .top || tt_titleAlignment == .bottom {
            // title size
            if tt_title.count > 0 {
                aTitleWidth = aContentWidth
                aTitleHeight = tt_titleSize.height
            }
            
            // 填充最大高度
            let aTotalVHeight = aTitleHeight + aImageHeight + tt_spacing
            
            // X位置
            aTitleX = aBorderWidth
            aImageX = aBorderWidth + (aContentWidth - aImageWidth) * 0.5
            
            // Y位置
            aTitleY = aBorderWidth + (aContentHeight - aTotalVHeight) * 0.5
            if (aTitleY < 0) { aTitleY = aBorderWidth }
            aImageY = aTitleY + aTitleHeight + tt_spacing
            if tt_titleAlignment == .bottom {
                aImageY = aTitleY
                aTitleY = aImageY + aImageHeight + tt_spacing
            }
        }
        
        // 左右
        if  tt_titleAlignment == .right || tt_titleAlignment == .left {
            // title size
            if tt_title.count > 0 {
                // height
                aTitleHeight = tt_titleSize.height
                // width
                aTitleWidth = tt_titleSize.width
            }
            // 填充最大宽度
            let aTotalVWidth = aTitleWidth + tt_spacing + aImageWidth
            
            // Y位置
            aImageY = aBorderWidth + (aContentHeight - aImageHeight) * 0.5
            aTitleY = aBorderWidth + (aContentHeight - aTitleHeight) * 0.5
            
            // X位置
            aTitleX = aBorderWidth + (aContentWidth - aTotalVWidth) * 0.5
            if (aTitleX < 0) { aTitleX = aBorderWidth }
            aImageX = aTitleX + aTitleWidth + tt_spacing
            if (tt_titleAlignment == .right) {
                aImageX = aTitleX
                aTitleX = aImageX + aImageWidth + tt_spacing
            }
        }
        
        // 下面逻辑不变
        // View: title
        if (tt_title.count > 0) {
            if let titleAttributes = tt_titleAttributes {
                t_titleAttributes = titleAttributes
            }
            
            aRect = NSMakeRect(aTitleX, aTitleY, aTitleWidth, aTitleHeight)
            tt_title.draw(in: aRect, withAttributes: t_titleAttributes)
        }
        
        // View: image
        if let _ = tt_image {
            aRect = NSMakeRect(aImageX, aImageY, aImageWidth, aImageHeight)
            tt_image?.draw(in: aRect)
        }
    }
}

// MARK: - Public Function

extension TTButton {
    
}

// MARK: - Private Function

extension TTButton {
    
    private func t_boundingRectWithSize(size: CGSize) -> CGSize {
        
        var aAttributes: [NSAttributedString.Key : Any] = [:]
        if let titleFont = tt_titleFont {
            aAttributes[NSAttributedString.Key.font] = titleFont
        }
        
        guard tt_title.count > 0 else {
            return .zero
        }
        
        return tt_title.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: aAttributes).size
    }
}

// MARK: - Initialize Function

extension TTButton {
    
    private func t_setupMakeInitialize() {
        cell = nil
        focusRingType = .none
        cell?.isBordered = false
        cell?.isHighlighted = false
        tt_backgroundColor = .clear
        tt_titleFont = font
    }
}

// MARK: - Keys

extension TTButton {
    
    public struct TTStateKey : Hashable, Equatable {
        
        public static let TTStateTitleKey: NSString = "StateTitleKey"
        public static let TTStateTitleColorKey: NSString = "StateTitleColorKey"
        public static let TTStateImageKey: NSString = "StateImageKey"
        public static let TTStateBackgroundImageKey: NSString = "StateBackgroundImageKey"
        
        public var rawValue: NSString
        
         static var title: NSControl.TTEventKey { return TTEventKey(rawValue: TTStateTitleKey) }
        
         static var titleColor: NSControl.TTEventKey { return TTEventKey(rawValue: TTStateTitleColorKey) }
        
         static var image: NSControl.TTEventKey { return TTEventKey(rawValue: TTStateImageKey) }
        
         static var backgroundImage: NSControl.TTEventKey { return TTEventKey(rawValue: TTStateBackgroundImageKey) }
    }
}
