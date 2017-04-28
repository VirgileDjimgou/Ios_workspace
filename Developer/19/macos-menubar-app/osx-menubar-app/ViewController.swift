//
//  ViewController.swift
//  osx-menubar-app
//
//  Created by Michael Kofler on 07.05.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let app = NSApplication.shared().delegate as! AppDelegate
    app.mainVC = self
  }
  
  // Fenster ausblenden
  @IBAction func btnHide(_ sender: NSButton) {
    view.window?.orderOut(self)
  }
  
}

