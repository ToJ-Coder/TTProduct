//
//  TTButton.swift
//  TTProduct
//
//  Created by Taurin on 1/5/21.
//

import Cocoa

enum TTLineStyle {
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
    
    public var tt_selected: Bool?
    public var tt_enabled: Bool?
    public var tt_enabledHighlighted: Bool?
    public var tt_userInteractionEnabled: Bool?
    
    public var tt_backgroundColor: NSColor?
    // 文字的渲染属性
    public var tt_titleAttributes: NSMutableDictionary?
    // 文字 与 图片间距
    public var tt_spacing: CGFloat?
    // 文字在图片的列序
    public var tt_titleAlignment: TTTitleAlignment?
    // 字体
    public var tt_titleFont: NSFont?
    // 文字是否有删除线
    public var tt_lineStyle: TTLineStyle?
    // 文字的列序
    public var tt_alignment: NSTextAlignment?
    // a... or a...b or ...a 等
    public var tt_lineBreakMode: NSLineBreakMode?
    
    public var tt_titleBackgroundColor: NSColor?
    
    // MARK: ReadOnly
    
    private(set) var tt_state: TTControlState = .normal {
        // 逻辑不用动
        didSet {
            
//            if (_cumulativeState & VIPControlStateDisabled) { return VIPControlStateDisabled;}
//            if (_cumulativeState & VIPControlStatePress) { return VIPControlStatePress; }
//            if (_cumulativeState & VIPControlStateHighlighted) { return VIPControlStateHighlighted; }
//            if (_cumulativeState & VIPControlStateSelected) {return VIPControlStateSelected; }
//            return VIPControlStateNormal;
        }
    }
    private(set) var tt_title: NSString?
    private(set) var tt_titleColor: NSColor?
    private(set) var tt_image: NSImage?
    private(set) var tt_backgroundImage: NSImage?
    // 文字宽高
    private(set) var tt_titleSize: CGSize?
    
    // MARK: Private
    
    private var tt_trackingArea: NSTrackingArea?
    
    // 添加的所有状态
    private var containedState: TTControlState?
    private var paragraphStyle: NSMutableParagraphStyle?
    // 文字的渲染属性
    private var titleAttributes: NSMutableDictionary?
    // 每个状态信息
    private var stateAttributes: NSMutableDictionary?
    private var tt_actions: [NSEvent.EventTypeMask.RawValue:NSMapTable<NSString, AnyObject>]?
    
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        self.tt_actions = [:]
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.tt_actions = [:]
    }
    /*
     STrackingMouseEnteredAndExited     = 0x01,//鼠标进入和退出
     NSTrackingMouseMoved                = 0x02,//鼠标移动
     NSTrackingCursorUpdate      = 0x04, //更新鼠标光标形状
     NSTrackingActiveWhenFirstResponder  = 0x10, //第一响应者时跟踪所有事件
     NSTrackingActiveInKeyWindow         = 0x20, //应用是key Window时 跟踪所有事件
     NSTrackingActiveInActiveApp     = 0x40, //应用是激活状态时跟踪所有事件
     NSTrackingActiveAlways      = 0x80, //跟踪所有事件（鼠标进入/退出/移动)
     
     NSTrackingAssumeInside              = 0x100,
     NSTrackingInVisibleRect             = 0x200,
     NSTrackingEnabledDuringMouseDrag    = 0x400
     */
    override func updateTrackingAreas() {
        guard tt_trackingArea == nil else { return }
        
        let options: NSTrackingArea.Options = [.mouseEnteredAndExited,
                                               .mouseMoved,
                                               .cursorUpdate,
                                               .activeAlways
        ]
        tt_trackingArea = NSTrackingArea(rect: bounds, options: options, owner: self, userInfo: nil)
        addTrackingArea(tt_trackingArea!)
    }
    
    override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
        return true
    }
    
    deinit {
        print(className + " : " + #function)
    }
}


extension TTButton {
    
    // 鼠标刚进入
    override func mouseEntered(with event: NSEvent) {
        self.tt_responseEvents(eventMask: .mouseEntered)
    }
    
    // 鼠标左键按下
    override func mouseDown(with event: NSEvent) {
        self.tt_responseEvents(eventMask: .leftMouseDown)
    }
    
    // 鼠标左键抬起
    override func mouseUp(with event: NSEvent) {
        self.tt_responseEvents(eventMask: .leftMouseUp)
    }
    
    // 鼠标离开
    override func mouseExited(with event: NSEvent) {
        
        self.tt_responseEvents(eventMask: .mouseExited)
    }
    
    private func tt_responseEvents(eventMask: NSEvent.EventTypeMask) {
        let map = tt_actions?[eventMask.rawValue]
        
        guard let aTarget = map?.object(forKey: TTEventTargetKey) else { return }
        let aAction = map?.object(forKey: TTEventActionKey) as? String ?? ""
        guard aAction.count > 0 else { return }
        
        NSApp.sendAction(Selector(aAction), to: aTarget, from: self)
    }
    
    // 光标事件
    override func cursorUpdate(with event: NSEvent) {
        tt_cursor?.set()
    }
}

extension TTButton: TTResponderProtocol {
    public func tt_addTarget(_ target:  AnyObject?, action: Selector, for controlEvents: NSEvent.EventTypeMask) {
        
        let map = NSMapTable<NSString, AnyObject>.strongToWeakObjects()
        map.setObject(target, forKey: TTEventTargetKey)
        let aAction = NSStringFromSelector(action) as NSString
        map.setObject(aAction, forKey: TTEventActionKey)
        
        tt_actions?[controlEvents.rawValue] = map
    }
    
    //    - (void)vip_setTitle:(NSString *_Nullable)title forState:(VIPControlState)state;
    //    - (void)vip_setTitleColor:(NSColor *_Nullable)color forState:(VIPControlState)state;
    //    - (void)vip_setImage:(NSImage *_Nullable)image forState:(VIPControlState)state;
    //    - (void)vip_setBackgroundImage:(NSImage *_Nullable)image forState:(VIPControlState)state;
}

extension TTButton {
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
}

