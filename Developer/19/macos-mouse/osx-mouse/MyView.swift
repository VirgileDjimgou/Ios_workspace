//
//  MyView.swift
//  osx-mouse
//
//  Created by Michael Kofler on 05.05.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

@IBDesignable
class MyView: NSView {
  
  var circles = [Circle]()
  
  override func draw(_ dirtyRect: NSRect) {
    // Hintergrund
    NSColor.white.setFill()
    NSRectFill(dirtyRect)
    
    // falls nicht NSView als Basisklasse,
    // sondern z. B. NSImageView:
    // Inhalt des Steuerelements zeichnen
    // super.drawRect(dirtyRect)
    
    // Vordergrund
    for c in circles {
      let path = NSBezierPath()
      path.appendArc(
        withCenter: NSPoint( x: c.x,
                             y: bounds.size.height - c.y),
            radius: c.radius,
        startAngle: 0,
          endAngle: 360)
      c.color.set()
      path.lineWidth = c.lineWidth
      path.stroke()
    }
  }
  
  override func mouseDown(with theEvent: NSEvent) {
    let locationInView =
      convert(theEvent.locationInWindow, from: nil)
    let x =  locationInView.x
    let y1 = locationInView.y           // macOS-Koordinatensystem
    let y2 = bounds.size.height - y1    // eigenes Koordinatensystem

    let r = CGFloat(20)
    let lw: CGFloat
    if theEvent.modifierFlags.contains(.shift)  {
      lw = CGFloat(4)
    } else {
      lw = CGFloat(2)
    }

    Swift.print("lw=\(lw)")
    
    let color = NSColor.red
    circles.append(Circle(x: x, y: y2,
                          radius: r,
                          lineWidth: lw,
                          color: color))
    
    // neu zu zeichnenden Bereich festlegen
    let rect = NSRect(
           x: x - r - lw ,
           y: y1 - r - lw,
       width: 2 * (r + lw),
      height: 2 * (r + lw))
    
    setNeedsDisplay(rect)
    // setNeedsDisplay(bounds)  // wesentlich langsamer!
    
  }
  
  override func mouseDragged(with theEvent: NSEvent) {
    mouseDown(with: theEvent)
  }
  
}
