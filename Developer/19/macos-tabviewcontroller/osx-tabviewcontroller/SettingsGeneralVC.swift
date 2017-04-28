//
//  SettingsGeneralVC.swift
//  osx-tabviewcontroller
//
//  Created by Michael Kofler on 04.05.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

class SettingsGeneralVC: NSViewController, NSTextFieldDelegate {
  
  var app = NSApplication.shared().delegate! as! AppDelegate
  var userDefaults = UserDefaults.standard
  
  @IBOutlet weak var sizestepper: NSStepper!
  @IBOutlet weak var fntsize: NSTextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fntsize.delegate = self
    
    // aktuelle Schriftgröße
    let size = userDefaults.integer(forKey: "fontsize")
    setAndSaveFontSize(size)
  }

  // Änderungen in den Steuerelementen
  @IBAction func sizestepper(_ sender: NSStepper) {
    setAndSaveFontSize(Int(sizestepper.stringValue)!)
  }
  override func controlTextDidChange(_ obj: Notification) {
    if let newsize = Int(fntsize.stringValue) {
      setAndSaveFontSize(newsize)
    }
  }
  
  // Schriftgröße in den Steuerelementen des Settings-Dialog
  // und im Hauptfenster einstellen, außerdem in den
  // User Defaults speichern
  fileprivate func setAndSaveFontSize(_ size:Int) {
    sizestepper.stringValue = "\(size)"
    fntsize.stringValue = "\(size)"
    userDefaults.set(size, forKey: "fontsize")
    app.mainVC.setFontSize(size)
  }
  
}
