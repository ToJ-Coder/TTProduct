//
//  TTDraggedView.swift
//  TTProduct-macOS
//
//  Created by Toj on 1/21/21.
//

import Cocoa

class TTDraggedView: NSView {
    var tapx : CGFloat?
    var tapy : CGFloat?
    
    override func mouseDown(with event: NSEvent) {
        let locationPoint = event.locationInWindow
        let cLoc = self.convert(locationPoint, from: superview)
        self.tapx = cLoc.x
        self.tapy = cLoc.y
    }
    override func mouseDragged(with event: NSEvent) {
        let topSlip: CGFloat = 0
        let locationPoint = event.locationInWindow
        guard let tapx = tapx, let tapy = tapy else { return }
        let newLoc = NSPoint(x: locationPoint.x - tapx, y: locationPoint.y - tapy)
        var x = newLoc.x >= 0 ? newLoc.x : 0
        var y = newLoc.y >= 0 ? newLoc.y : 0
        guard let superBounds = superview?.bounds else { return }
        if newLoc.x + self.bounds.width > superBounds.width {
            x = superBounds.width - self.bounds.width
        }
        if newLoc.y + self.bounds.height + topSlip > superBounds.height {
            y = superBounds.height - self.bounds.height - topSlip
        }
        self.setFrameOrigin(NSPoint(x: x, y: y))
    }
    
    override func mouseUp(with event: NSEvent) { }
}
