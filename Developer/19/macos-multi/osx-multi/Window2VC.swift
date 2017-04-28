//
//  Window2VC.swift
//  osx-multi
//
//  Created by Michael Kofler on 02.05.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

class Window2VC: NSViewController {
  
  @IBOutlet weak var label: NSTextField!
  var data: String? {
    didSet {
      label?.stringValue = data!
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    label.stringValue = data ?? "keine Nachricht"
  }
  override func viewDidAppear() {
    super.viewDidAppear()
    let win = view.window!
    win.title = "Noch ein Fenster"
  }
  
  @IBAction func btnClose(_ sender: NSButton) {
    //  dismissController(sender)  funktioniert hier nicht
    view.window?.close()
  }
  
  // Referenz an den Controller des modalen Dialogs übergeben
  override func prepare(for segue: NSStoryboardSegue,
                        sender: Any?)
  {
    if let dest = segue.destinationController as? ModalVC {
      dest.srcVC = self
    }
  }
  
}
