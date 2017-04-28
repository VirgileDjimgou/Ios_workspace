//
//  AppDelegate.swift
//  osx-menubar-app
//
//  Created by Michael Kofler on 07.05.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  var mainVC:ViewController!
  let statusBarItem =
    NSStatusBar.system().statusItem(withLength: -1)
  
  func applicationDidFinishLaunching(_ aNotification: Notification) {
    // Icon für MenuBar-Eintrag
    let icon = NSImage(named: "flag")
    // icon?.setTemplate(true)  // bei Bitmaps ohne Transparenz
    statusBarItem.image = icon
    
    // Menüeinträge hinzufügen
    let menu: NSMenu = NSMenu()
    var menuItem  = NSMenuItem()
    menuItem.title = "Fenster anzeigen"
    menuItem.action = #selector(AppDelegate.showMyWindow(_:))
    menu.addItem(menuItem)

    menuItem  = NSMenuItem()
    menuItem.title = "Beenden"
    menuItem.action = #selector(AppDelegate.quit(_:))
    menu.addItem(menuItem)

    // Menü mit Statusbar-Element verbinden
    statusBarItem.menu = menu
  }
  
  // Reaktion auf Menüeintrag
  func showMyWindow(_ sender:NSMenuItem) {
    mainVC?.view.window?.makeKeyAndOrderFront(self)
  }
  func quit(_ sender:NSMenuItem) {
    NSApplication.shared().terminate(self)
  }
}

