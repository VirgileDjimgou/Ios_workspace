//
//  AppDelegate.swift
//  osx-lotto-xib-viewcontroller
//
//  Created by Michael Kofler on 02.05.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  @IBOutlet weak var window: NSWindow!
  
  var mainvc:LottoViewController?
  

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    if let lvc = LottoViewController(
      nibName: "LottoViewController", bundle:nil)
    {
      window.contentView!.addSubview(lvc.view)
      lvc.view.frame = window.contentView!.bounds
      mainvc = lvc
    }
  }
}

