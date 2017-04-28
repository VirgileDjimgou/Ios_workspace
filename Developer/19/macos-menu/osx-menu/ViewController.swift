//
//  ViewController.swift
//  osx-menu
//
//  Created by Michael Kofler on 07.05.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  
  @IBOutlet weak var mylabel: NSTextField!
 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Rückverweis in AppDelegate-Objekt
    let app = NSApplication.shared().delegate as! AppDelegate
    app.mainVC = self
  }
  
  // Action-Methode für 'Test 2'
  @IBAction func menuTest2(_ sender: NSMenuItem) {
    mylabel.stringValue = "Test 2"
    print("Menüeintrag Test 2")
  }
  
}

