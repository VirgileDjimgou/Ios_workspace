//
//  OriginalIconView.swift
//  macos-icon-resize
//
//  Created by Michael Kofler on 22.04.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

// modifizierte NSView-Klasse, um Drag 
// einer Bilddatei zu verarbeiten
class OriginalIconView: NSView {
  
  // Referenz auf den übergeordneten View Controller
  weak var vc: ViewController!

  var highlight = false {
    didSet { setNeedsDisplay(bounds) }
  }
  
  override func draw(_ dirtyRect: NSRect) {
    if highlight {
      NSColor.gray.setFill()
      NSRectFill(dirtyRect)
    }
    super.draw(dirtyRect)
    
  }
  
  // Drag beginnt; .Copy anzeigen, wenn Daten OK
  override func draggingEntered(_ sender: NSDraggingInfo)
    -> NSDragOperation
  {
    if dragFilename(sender) != nil {
      highlight = true
      return .copy
    }
    return NSDragOperation()
  }
  
  override func draggingExited(_ sender: NSDraggingInfo?) {
    highlight = false
  }
  
  
  // Drag abgeschlossen: Icon-Datei laden
  override func performDragOperation(_ sender: NSDraggingInfo)
    -> Bool
  {
    if let fname = dragFilename(sender)  {
      vc.icon = NSImage(contentsOfFile: fname)
      return true
    }
    return false
  }
  
  override func concludeDragOperation(_ sender: NSDraggingInfo?) {
    highlight = false
  }
  
  // Dateiauswahldialog anzeigen
  override func mouseDown(with theEvent: NSEvent) {
    let openFile = NSOpenPanel()
    openFile.title = "Icon-Datei öffnen"
    openFile.prompt = "Öffnen"
    openFile.worksWhenModal = true
    openFile.allowsMultipleSelection = false
    openFile.allowedFileTypes =
      ["png", "jpg", "jpeg", "PNG", "JPEG", "JPG"]
    openFile.canChooseDirectories = false
    openFile.resolvesAliases = true

    // Dialog anzeigen
    openFile.runModal()
    if let  url = openFile.url {
      vc.icon = NSImage(contentsOfFile: url.path)
    }
  }

  
  // NSDraggingInfo-Objekt verarbeiten; liefert
  // Dateinamen der Icon-Datei zurück oder nil, 
  // wenn ungültige Daten
  private func dragFilename(_ draginfo: NSDraggingInfo)
    -> String?
  {
    let pboard = draginfo.draggingPasteboard()
    if draginfo.numberOfValidItemsForDrop == 1,
       let data = pboard.propertyList(
                    forType: NSFilenamesPboardType) as? [String],
       let path = data.first
    {
      let app =
        NSApplication.shared().delegate as! AppDelegate
      if path.hasPrefix(app.tempdir) {
        return nil
      }
      
      // Extension herausfinden
      let url = URL(fileURLWithPath: path)
      let ext = url.pathExtension
      
      switch ext.lowercased() {
      case "png", "jpeg", "jpg":
        return String(path)
      default:
        return nil
      }
    }
    return nil
  }  // func-Ende
}    // class-Ende
