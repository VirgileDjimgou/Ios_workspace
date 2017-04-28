//
//  MyView.swift
//  osx-drag-drop
//
//  Created by Michael Kofler on 28.04.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

// eigene MyView-Klasse, abgeleitet von NSImageView
// unterstützt Drag & Drop

// MARK: Teil 1 -- Eigenschaften und drawRect-Methode
class MyView: NSImageView {
  
  // welche Operationen unterstützt die View
  // als Quelle und als Ziel
  var dragSrcOp: NSDragOperation = NSDragOperation()
  var dragDestOp: NSDragOperation = NSDragOperation()
  
  // zur Kennzeichnung, wenn aktiv als Drag-Empfänger
  var myhighlight = false {
    didSet { setNeedsDisplay() }
  }
  
  // blauen Rahmen um Element zeichnen, wenn myhighlight = true
  override func draw(_ dirtyRect: NSRect) {
    // Inhalt wie üblich zeichnen
    super.draw(dirtyRect)
    // danach Rahmen dazu
    if myhighlight {
      let path = NSBezierPath()
      path.appendRoundedRect(
        NSInsetRect(bounds, 2.5, 2.5), xRadius:3, yRadius:3)
      path.lineWidth = 2.5
      NSColor.blue.set()
      path.stroke()
     }
  }
}

// MARK: Teil 2 -- Drag&Drop-Quelle
// als Drag&Drop-Quelle agieren (Drag&Drop initiieren)
extension MyView: NSDraggingSource {

  // Drag starten (Quelle)
  // mouseDragged ist keine NSDragging-Source-Methode
  override func mouseDragged(with theEvent: NSEvent) {
    // wenn ImageView leer ist oder dragSrcOp == .none:
    // kein Drag möglich
    if image == nil || dragSrcOp == NSDragOperation() { return }
    
    let data = NSDraggingItem(pasteboardWriter: "Drag&Drop test" as NSPasteboardWriting)
    
    // aktuelle Mausposition relativ zum aktuellen NSView
    let position = convert(theEvent.locationInWindow,
                           from: nil)
    data.imageComponentsProvider =
      { // Closure, legt das während des Drag-Vorgangs
        // anzuzeigende Bild fest
        let component = NSDraggingImageComponent(
                         key: NSDraggingImageComponentIconKey)
        component.contents = self.image

        // 50x50 Vorschaubild mittig um aktuelle Mausposition
        component.frame = NSRect(
          origin: NSPoint(x: position.x-25, y: position.y-25),
          size: NSSize(width: 50, height: 50))
        return [component]
    }
    
    // mit dieser Methode enden die mouseDragged-Aufrufe
    beginDraggingSession(
      with: [data], event: theEvent, source: self)
  }
  
  // welche Drag-Operationen werden unterstützt (als Quelle)
  func draggingSession(_ session: NSDraggingSession,
    sourceOperationMaskFor context: NSDraggingContext)
    -> NSDragOperation
  {
    if self.image == nil {
      // image ist leer, also gibt es nichts
      // zum Verschieben/Kopieren etc.
      return NSDragOperation()
    } else {
      return dragSrcOp
    }
  }
  
  // Benachrichtigung über Ende des Drag-Vorgangs an die Quelle
  func draggingSession(_ session: NSDraggingSession,
    endedAt screenPoint: NSPoint,
    operation: NSDragOperation)
  {
    if operation == .delete || operation == .move {
      image = nil
    }
  }
}

// MARK: Teil 3 -- Drag&Drop-Empfänger
// als Drag&Drop-Empfänger agieren
// war ursprünglich extension MyView: NSDraggingDestination,
// aber NSImageView implementiert bereits NSDraggingDestination
extension MyView {

  // Drag-Objekt betritt View als Ziel; wenn akzeptabel,
  // optisches Feedback geben
  override func draggingEntered(_ sender: NSDraggingInfo)
    -> NSDragOperation
  {
    
    // Quelle und Ziel darf nicht übereinstimmen
    if let view = sender.draggingSource() as? MyView,
      view === self
    {
      return NSDragOperation()
    }
    
    // String-Drags
    if dragString(sender)  {
      // mask: erlaubte Sender-Operationen, evt.
      // durch alt-Taste auf Copy reduziert
      let mask = sender.draggingSourceOperationMask()
      // and-Verknüpfung mit erlaubten Ziel-Operationen
      let result = mask.intersection(dragDestOp)
      
      // es ist möglich, dass nun mehrere Operationen zulässig
      // sind; eine auswählen
      if result.contains(.move) {
        myhighlight = true
        return .move
      } else if result.contains(.copy)  {
        myhighlight = true
        return .copy
      } else if result.contains(.delete)  {
        myhighlight = true
        return .delete
      }
    }
    
    // File-Drags: nur Copy akzeptieren
    if dragFilename(sender) != nil &&
       dragDestOp.contains(.copy)
    {
      myhighlight = true
      return .copy
    }
    
    // keine passenden Daten
    return NSDragOperation()
  }
  
  override func draggingUpdated(_ sender: NSDraggingInfo)
    -> NSDragOperation
  {
    return draggingEntered(sender)
  }
  
  // Drag-Objekt verlässt View ohne Drop; optisches
  // Feedback wieder abschalten
  override func draggingExited(_ sender: NSDraggingInfo?) {
    myhighlight = false
  }
  
  // Drop verarbeiten (als Ziel)
  override func performDragOperation(_ sender: NSDraggingInfo)
      -> Bool
  {
    // String-Drag abgeschlossen
    if dragString(sender)  {
      // wenn Destination Move oder Copy erlaubt und
      // wenn der Quellobjekt ein MyView-Objekt ist:
      // Bild kopieren
      if dragDestOp.contains(.move) || dragDestOp.contains(.copy),
         let src = sender.draggingSource() as? MyView
      {
        self.image = src.image
      }
      return true
    }
    
    // File-Drag abgeschlossen: Icon-Datei laden
    if let fname = dragFilename(sender)  {
      image = NSImage(byReferencingFile: fname)
      return true
    }
    return false
  }

  // Drop abschließen (als Ziel)
  override func concludeDragOperation(_ sender: NSDraggingInfo?) {
    // Hintergrundfarbe wieder zurücksetzen
    myhighlight = false
  }
  
  // NSDraggingInfo-Objekt vom Typ NSFilenamsPboardType verarbeiten;
  // liefert Dateinamen der Icon-Datei zurück oder nil,
  // wenn ungültige Daten (>1 Element, falscher Typ)
  private func dragFilename(_ draginfo: NSDraggingInfo) -> String? {
    let pboard = draginfo.draggingPasteboard()
    if draginfo.numberOfValidItemsForDrop == 1,
       let data = pboard.propertyList(
                    forType: NSFilenamesPboardType) as? [String],
       let fname = data.first
    {
      let nsFname = NSString(string: fname)
      switch nsFname.pathExtension.lowercased() {
      case "png", "jpeg", "jpg":
        return String(fname)
      default:
        return nil
      }
    }
    return nil
  }

  // NSDraggingInfo-Objekt vom Typ String verarbeiten;
  // liefert true/false zurück
  private func dragString(_ draginfo: NSDraggingInfo) -> Bool {
    let pboard = draginfo.draggingPasteboard()
    if draginfo.numberOfValidItemsForDrop == 1,
       let data = pboard.readObjects(forClasses: [NSString.self],
                                     options: [:]) as? [String],
       data.first == "Drag&Drop test"
    {
      return true
    }
    return false
  }
  
}
