//
//  ViewController.swift
//  osx-keyboard
//
//  Created by Michael Kofler on 06.05.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

  @IBOutlet var mainview: MyView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // MyView-Eigenschaften initialisieren, dann neu zeichnen
    mainview.x = (mainview.bounds.width - mainview.size) / 2
    mainview.y = (mainview.bounds.height - mainview.size) / 2
    mainview.img = mainview.forward
    mainview.setNeedsDisplay(mainview.bounds)
  }
}

