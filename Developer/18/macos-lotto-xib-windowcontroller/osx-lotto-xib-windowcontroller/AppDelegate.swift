//
//  AppDelegate.swift
//  osx-lotto-xib-windowcontroller
//
//  Created by Michael Kofler on 02.05.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  var lottoWinCtrl:LottoWindowController!
  
  func applicationDidFinishLaunching(_ aNotification: Notification) {
    lottoWinCtrl =
      LottoWindowController(windowNibName: "LottoWindowController")
    lottoWinCtrl.showWindow(self)
  }
}

