//
//  TTTitleBar.swift
//  TTProduct
//
//  Created by Toj on 1/4/21.
//

import Cocoa
import TTCOM_macOS

class TTTitleBar: NSView {
    var leftMargin: CGFloat = TTLeftMargin
    var rightMargin: CGFloat = TTRightMargin
    
    var leftView: NSView? {
        willSet {
            leftView?.removeFromSuperview()
            guard let leftView = newValue else { return }
            addSubview(leftView)
        }
    }
    
    var rightView: NSView? {
        willSet {
            rightView?.removeFromSuperview()
            guard let rightView = newValue else { return }
            addSubview(rightView)
        }
    }
    
    var leftViews: [NSView]? {
        willSet {
            leftViews?.forEach({ (view) in
                view.removeFromSuperview()
            })
            
            newValue?.forEach({ (view) in
                addSubview(view)
            })
            let count = newValue?.count ?? 0
            leftView?.isHidden = count != 0
        }
    }
    
    var rightViews: [NSView]? {
        willSet {
            rightViews?.forEach({ (view) in
                view.removeFromSuperview()
            })
            
            newValue?.forEach({ (view) in
                addSubview(view)
            })
            let count = newValue?.count ?? 0
            rightView?.isHidden = count != 0
        }
    }
    
    var title: String = "" {
        didSet {
            if let titleBarView = titleView,
               titleBarView is TTLabel,
               let titleView = titleBarView as? TTLabel {
                titleView.stringValue = title
            }
        }
    }
    
    var titleView: NSView? = {
        let view = TTLabel()
        view.textColor = NSColor(calibratedRed: 1, green: 1, blue: 1, alpha: 0.83)
        view.alignment = .center
        view.font = NSFont.systemFont(ofSize: 13)
        return view
    }() {
        willSet {
            guard let titleView = newValue else { return }
            titleView.removeFromSuperview()
            addSubview(titleView)
        }
    }
    
    private lazy var bottomLineView: NSView = {
        let view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.black.cgColor
        return view
    }()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        wantsLayer = true
        addSubview(titleView!)
        addSubview(bottomLineView)
        
        layer?.backgroundColor = NSColor(calibratedRed: 44/255.0, green: 44/255.0, blue: 44/255.0, alpha: 1).cgColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        print(className + " : " + #function)
    }
}

extension TTTitleBar{
    static let TTDefaultHeight: CGFloat = 22
    static let TTLeftMargin: CGFloat = 65
    static let TTRightMargin: CGFloat = 35
}

// MARK: - override
extension TTTitleBar {
    
    override func hitTest(_ point: NSPoint) -> NSView? {
        let hitView = super.hitTest(point)
        if hitView == self {
            return nil
        }
        return hitView
    }
    
    override func layout() {
        super.layout()
        setupMakeLayoutSubviews()
    }
}

// MARK: - setup
extension TTTitleBar {
    
    private func setupMakeLayoutSubviews() {
        let defaultSize: CGSize = CGSize(width: 20, height: 20)
        
        bottomLineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(1)
        }
        
        if let titleView = titleView {
            let size = titleView.frame.size
            titleView.snp.makeConstraints({ (make) in
                make.center.equalTo(self)
                guard !titleView.isKind(of: TTLabel.self) else { return }
                make.width.equalTo(size.width)
                make.height.equalTo(size.height)
            })
        }
        
        if let leftView = leftView {
            var size = leftView.frame.size
            if size == .zero { size = defaultSize }
            
            leftView.snp.remakeConstraints({ (make) in
                make.left.equalTo(leftMargin)
                make.centerY.equalTo(self)
                make.width.equalTo(size.width)
                make.height.equalTo(size.height)
            })
        }
        
        if let rightView = rightView {
            var size = rightView.frame.size
            if size == .zero { size = defaultSize }
            
            rightView.snp.remakeConstraints({ (make) in
                make.right.equalTo(snp.right).offset(-rightMargin)
                make.centerY.equalTo(self)
                make.width.equalTo(size.width)
                make.height.equalTo(size.height)
            })
        }
        
        var size: CGSize = .zero
        let margin: CGFloat = 25
        var left: CGFloat = leftMargin
        leftViews?.forEach({ (view) in
            size = view.frame.size == .zero ? defaultSize : view.frame.size
            
            view.snp.remakeConstraints { (make) in
                make.left.equalTo(left)
                make.centerY.equalTo(self)
                make.width.equalTo(size.width)
                make.height.equalTo(size.height)
            }
            left = left + size.width + margin
        })
        
        var right: CGFloat = rightMargin
        rightViews?.reversed().forEach({ (view) in
            size = view.frame.size == .zero ? defaultSize : view.frame.size
            
            view.snp.remakeConstraints { (make) in
                make.right.equalTo(snp.right).offset(-right)
                make.centerY.equalTo(self)
                make.width.equalTo(size.width)
                make.height.equalTo(size.height)
            }
            right = right + size.width + margin
        })
    }
}
