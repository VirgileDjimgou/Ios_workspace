//
//  ClickImageView.swift
//  macos-icon-resize
//
//  Created by Michael Kofler on 25.04.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

// Klasse für NSView, die anklickbar ist
// und als Drag&Drop-Source fungiert
class IconCellView: NSView, NSDraggingSource {
  
  var isize: IconSize!
  var rtype: RetinaType!
  var icon: NSImage!
  
  // sonst wird mouseDragged nicht aufgerufen
  override func mouseDown(with theEvent: NSEvent) {
  }
  
  override func mouseDragged(with theEvent: NSEvent) {
    // kein Drag wenn keine Daten
    if icon == nil  { return }
    let app =
      NSApplication.shared().delegate as! AppDelegate
   
    // Icon in temp. Verz. speichern
    let fname = isize.save(icon,
                           type: rtype,
                           folder: app.tempdir!)

    // Mausposition
    let position = convert(theEvent.locationInWindow, from: nil)
    let mouserect = NSRect(origin: position,
                           size: NSSize(width: 10, height: 10))
    
    // start drag
    dragFile(fname,
             from: mouserect,
             slideBack: true,
             event: theEvent)
  }
  
  // nur Copy erlauben
  func draggingSession(_: NSDraggingSession,
                       sourceOperationMaskFor _: NSDraggingContext)
    -> NSDragOperation
  {
    return .copy
  }
}
