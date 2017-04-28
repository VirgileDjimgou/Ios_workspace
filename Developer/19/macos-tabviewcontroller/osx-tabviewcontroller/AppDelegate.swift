//
//  AppDelegate.swift
//  osx-tabviewcontroller
//
//  Created by Michael Kofler on 03.05.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  
  var mainVC:ViewController!

  // Defaults für userDefaults sofort initialisieren --
  // in applicationWillFinishLaunching oder
  // -DidFinishLaunching ist es zu spät!
  override init() {
    super.init()
    let userDefaults = UserDefaults.standard
    if let url = Bundle.main.url(
      forResource: "appdefaults", withExtension: "plist"),
      let appDefaults = NSDictionary(contentsOf: url)
    {
      userDefaults.register(
        defaults: appDefaults as! [String : AnyObject])
    }
  }

}

