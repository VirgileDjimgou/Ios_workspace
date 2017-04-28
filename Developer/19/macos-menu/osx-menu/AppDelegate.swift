//
//  AppDelegate.swift
//  osx-menu
//
//  Created by Michael Kofler on 07.05.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  weak var mainVC:ViewController?

  @IBAction func menuTest1(_ sender: NSMenuItem) {
    print("Menüeintrag Test 1")
    mainVC?.mylabel.stringValue = "Test 1"
  }

}

