//
//  ViewController2.swift
//  osx-menu
//
//  Created by Michael Kofler on 07.05.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

class ViewController2: NSViewController {
  
  @IBOutlet weak var label: NSTextField!
  @IBOutlet var contextMenu: NSMenu!
  
  
  override func viewDidAppear() {
    // Fenstertitel einstellen
    super.viewDidAppear()
    let win = view.window!
    win.title = "Fenster 2"
    // Kontextmenü einrichten
    view.menu = contextMenu
  }
  
  // Action-Methode für 'Test 3'
  @IBAction func menuTest3(_ sender: NSMenuItem) {
    label.stringValue = "Test 3"
    print("Menüeintrag Test 3")
  }
  // Action-Methode für 'Test 4'
  @IBAction func menuTest4(_ sender: NSMenuItem) {
    label.stringValue = "Test 4"
    print("Menüeintrag Test 4")
    if sender.state == NSOffState {
      sender.state = NSOnState
    } else {
      sender.state = NSOffState
    }
  }
  
  // Action-Methode für alle drei Kontextmenüeinträge
  @IBAction func menuContext(_ sender: NSMenuItem) {
    label.stringValue = sender.title
    print("Kontextmenüeintrag \(sender.title)")
  }
}
