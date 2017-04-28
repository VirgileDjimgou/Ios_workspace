//
//  InfoVC.swift
//  macos-icon-resize
//
//  Created by Michael Kofler on 25.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import Cocoa

class InfoVC: NSViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewDidAppear() {
    // Fenstereigenschaften einstellen
    view.window?.title = "Info"
    
    view.window?.styleMask = [.titled, .closable]
    
  }
  
  @IBAction func btnWeb(_ sender: AnyObject) {
    let url = URL(string: "https://kofler.info/buecher/swift")!
    NSWorkspace.shared().open(url)
  }
}
