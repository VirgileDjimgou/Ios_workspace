//
//  MyView.swift
//  osx-keyboard
//
//  Created by Michael Kofler on 06.05.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

class MyView: NSView {
  // Bitmaps sind im Images.xcassets
  let forward = NSImage(named: "hockey")!
  let backward = NSImage(named: "hockey-back")!
  let size: CGFloat = 64
  
  // Eigenschaften
  var x: CGFloat!   // x-Koordinate
  var y: CGFloat!   // y-Koordinate, von oben gerechnet!
  var img: NSImage!
  
  override var acceptsFirstResponder: Bool { return true }
  
  // Hockey-Spieler zeichnen
  override func draw(_ dirtyRect: NSRect) {
    if img == nil { return }
    x = max(0, min(bounds.width - size, x))
    y = max(0, min(bounds.height - size, y))
    let rect = NSRect(x: x,
                      y: bounds.height - y - size,
                  width: size,
                 height: size)
    img.draw(in: rect)
  }
  
  // wird First Responder bzw. agiert nicht mehr First Responder
  override func becomeFirstResponder() -> Bool {
    return true
  }
  override func resignFirstResponder() -> Bool {
    return true
  }
  
  override func keyDown(with theEvent: NSEvent) {
    interpretKeyEvents([theEvent])
  }

  override func insertText(_ insertString: Any) {
    if let input = insertString as? String {
      switch  input.lowercased() {
      case "j":
        moveLeft(self)
      case "k":
        moveLeft(self)
      case "i":
        moveUp(self)
      case "m":
        moveDown(self)
      default:
        break
      }
      
    }
  }
  
  override func moveLeft(_ sender: Any?) {
    x = x - 10
    img = backward
    setNeedsDisplay(bounds)
  }
  override func moveRight(_ sender: Any?) {
    x = x + 10
    img = forward
    setNeedsDisplay(bounds)
  }
  override func moveDown(_ sender: Any?) {
    y = y + 10
    setNeedsDisplay(bounds)
  }
  override func moveUp(_ sender: Any?) {
    y = y - 10
    setNeedsDisplay(bounds)
  }
  
  
}
