//
//  AppDelegate.swift
//  macos-icon-resize
//
//  Created by Michael Kofler on 21.04.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  var tempdir: String!

  // wird beim Start der App ausgeführt
  func applicationDidFinishLaunching(_ aNotification: Notification) {
    let fmgr = FileManager.default
    
    // Unterverzeichnis icon-resizer im temporären Verzeichnis
    let temp = NSString(string: NSTemporaryDirectory())
      .appendingPathComponent("icon-resizer")
    do {
      // existiert schon? löschen!
      if fmgr.fileExists(atPath: temp) {
        try fmgr.removeItem(atPath: temp)
      }
      
      // erzeugen
      try fmgr.createDirectory(atPath: temp,
        withIntermediateDirectories: false,
        attributes: nil)
      tempdir = temp
    } catch _ {
      // wenn Fehler passieren: einfach temporäres Verzeichnis verwenden
      tempdir = NSTemporaryDirectory()
    }
  }
  

  func applicationWillTerminate(_ aNotification: Notification) {
    if tempdir.hasSuffix("icon-resizer") {
      let fmgr = FileManager.default
      do {
        // temporäres Verzeichnis wieder löschen
        try fmgr.removeItem(atPath: tempdir)
        print("Tempdir gelöscht")
      } catch _ { }
    }
  }
}

