//
//  ViewController.swift
//  osx-dialogs
//
//  Created by Michael Kofler on 06.05.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  
  @IBOutlet weak var txtMessage: NSTextField!
  @IBOutlet weak var txtFilename: NSTextField!
  @IBOutlet weak var txtFilename2: NSTextField!
  @IBOutlet weak var txtFont: NSTextField!
  @IBOutlet weak var txtColor: NSTextField!
  @IBOutlet weak var colorwell: NSColorWell!

  // Message Box
  @IBAction func btnMessage(_ sender: NSButton) {
    let alert = NSAlert()
    alert.messageText = "Wollen Sie das Objekt löschen?"
    alert.addButton(withTitle: "Abbrechen")
    alert.addButton(withTitle: "Löschen")
    alert.alertStyle = .warning // .CriticalAlertStyle // .InformationalAlertStyle
    alert.icon = NSImage(named: "warning") // aus Images.xcassets
    
    switch alert.runModal() {
    case NSAlertFirstButtonReturn:
      txtMessage.stringValue = "Abbrechen"
    case NSAlertSecondButtonReturn:
      txtMessage.stringValue = "Löschen"
    default:
      break
    }
  }
  
  // Dateiauswahl
  @IBAction func btnFileOpen(_ sender: NSButton) {
    let openFile = NSOpenPanel()
    openFile.title = "Datei öffnen"
    openFile.prompt = "Öffnen"
    openFile.worksWhenModal = true
    openFile.allowsMultipleSelection = false
    openFile.canChooseDirectories = false
    openFile.canChooseFiles = true
    openFile.canCreateDirectories = true
    openFile.resolvesAliases = true
    openFile.runModal()
    if let url = openFile.url {
      txtFilename.stringValue = url.path
    }
  }
  @IBAction func btnFileSave(_ sender: NSButton) {
    let saveFile = NSSavePanel()
    saveFile.title = "Datei speichern"
    saveFile.prompt = "Speichern"
    saveFile.worksWhenModal = true
    saveFile.canCreateDirectories = true
    saveFile.runModal()
    if let url = saveFile.url  {
      txtFilename2.stringValue = url.path
    }
  }

  // Font-Auswahl
  @IBAction func btnChooseFont(_ sender: NSButton) {
    let fontmanager = NSFontManager.shared()
    fontmanager.target = self
    fontmanager.setSelectedFont(txtFont.font!, isMultiple: false)
    fontmanager.orderFrontFontPanel(self)
  }
  // Reaktion auf Auswahl einer neuen Schriftart
  // http://stackoverflow.com/questions/13614769
  override func changeFont(_ sender: Any?) {
    let oldfont=txtFont.font!
    let newfont = NSFontManager.shared().convert(oldfont)
    txtFont.font = newfont
  }

  
  // Farbauswahl mit Button
  @IBAction func btnChooseColor(_ sender: NSButton) {
    let colorpanel = NSColorPanel.shared()
    colorpanel.setTarget(self)
    colorpanel.setAction(#selector(ViewController.newColor(_:)))
    colorpanel.makeKeyAndOrderFront(self)
  }
  func newColor(_ sender:AnyObject?) {
    let colorpanel = NSColorPanel.shared()
    txtColor.textColor =  colorpanel.color
    colorwell.color = colorpanel.color
  }
  // Farbauswahl mit Color Well
  @IBAction func colorSelect(_ sender: NSColorWell) {
    txtColor.textColor = sender.color
  }
  
  
  
  override func viewDidDisappear() {
    NSApplication.shared().terminate(self)
  }
}

