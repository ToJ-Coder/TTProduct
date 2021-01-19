//
//  TTLabelCell.swift
//  TTProduct
//
//  Created by Toj on 1/8/21.
//

import Cocoa

open class TTLabelCell: NSTextFieldCell {
    
    private var t_mIsEditingOrSelecting: Bool = false
    
    open override func drawingRect(forBounds theRect: NSRect) -> NSRect {
        var newRect:NSRect = super.drawingRect(forBounds: theRect)
        if !t_mIsEditingOrSelecting {
            let textSize:NSSize = self.cellSize(forBounds: theRect)
            
            let heightDelta: CGFloat = newRect.size.height - textSize.height
            
            if heightDelta > 0 {
                newRect.size.height -= heightDelta
                newRect.origin.y += heightDelta/2
            }
        }
        return newRect
    }
    
    open override func select(withFrame rect: NSRect,
                         in controlView: NSView,
                         editor textObj: NSText,
                         delegate: Any?,
                         start selStart: Int,
                         length selLength: Int) {
        let arect = self.drawingRect(forBounds: rect)
        t_mIsEditingOrSelecting = true
        super.select(withFrame: arect, in: controlView, editor: textObj, delegate: delegate, start: selStart, length: selLength)
        t_mIsEditingOrSelecting = false
    }
    
    open override func edit(withFrame rect: NSRect,
                       in controlView: NSView,
                       editor textObj: NSText,
                       delegate: Any?,
                       event: NSEvent?) {
        let aRect = self.drawingRect(forBounds: rect)
        t_mIsEditingOrSelecting = true
        super.edit(withFrame: aRect, in: controlView, editor: textObj, delegate: delegate, event: event)
        t_mIsEditingOrSelecting = false
    }
}
