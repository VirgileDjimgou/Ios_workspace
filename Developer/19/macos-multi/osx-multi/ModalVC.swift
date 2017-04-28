
//
//  ModalVC.swift
//  osx-multi
//
//  Created by Michael Kofler on 02.05.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

class ModalVC: NSViewController {
  
  weak var srcVC: Window2VC!
  
  override func viewDidAppear() {
    super.viewDidAppear()
    view.window?.title = "Ein modaler Dialog"
    view.window?.styleMask = .titled
    // mehrere Attribute: Array verwenden!
    // view.window?.styleMask = [.titled, .closable]
  }
  @IBAction func btnNo(_ sender: NSButton) {
    srcVC.label.stringValue = "Nein"
    dismiss(sender)
  }
  
  @IBAction func btnYes(_ sender: NSButton) {
    srcVC.label.stringValue = "Ja"
    dismiss(sender)
  }
}
