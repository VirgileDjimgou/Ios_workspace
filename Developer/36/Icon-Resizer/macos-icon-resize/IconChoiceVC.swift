//
//  IconChoiceVC.swift
//  macos-icon-resize
//
//  Created by Michael Kofler on 25.04.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

class IconChoiceVC: NSViewController {
  
  @IBOutlet weak var btnIos: NSButton!
  @IBOutlet weak var btnMacos: NSButton!
  @IBOutlet weak var btnWatch: NSButton!
  
  weak var mainVC:ViewController!

  override func viewDidLoad() {
    super.viewDidLoad()
    switch mainVC.iconset {
    case .iOS:     btnIos.state   = NSOnState
    case .macOS:   btnMacos.state = NSOnState
    case .watchOS: btnWatch.state = NSOnState
    }
  }
  
  // einer der Buttons wurde angeklickt
  @IBAction func btnIos(_ sender: AnyObject) {
    mainVC.iconset = IconSet.iOS
    dismiss()
  }
  @IBAction func btnMacos(_ sender: AnyObject) {
    mainVC.iconset = IconSet.macOS
    dismiss()
  }
  @IBAction func btnWatch(_ sender: NSButton) {
    mainVC.iconset = IconSet.watchOS
    dismiss()
  }

  
  private func dismiss() {
    mainVC.iconsizes =
      IconSize.getSizes(set: mainVC.iconset)
    mainVC.iconTable.reloadData()
    self.dismiss(self)
  }
}
