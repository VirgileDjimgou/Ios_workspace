//
//  ViewController.swift
//  macos-sandbox
//
//  Created by Michael Kofler on 23.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let homepath = NSHomeDirectory()
    print(homepath)
  }

  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }


}

