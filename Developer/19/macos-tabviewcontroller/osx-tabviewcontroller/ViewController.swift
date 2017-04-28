//
//  ViewController.swift
//  osx-tabviewcontroller
//
//  Created by Michael Kofler on 03.05.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  @IBOutlet var txtfield: NSTextView!

  var userDefaults = UserDefaults.standard
  let app = NSApplication.shared().delegate! as! AppDelegate
  
  override func viewDidLoad() {
    app.mainVC = self
    // Schriftgröße aus Defaults laden und setzen
    let size = userDefaults.integer(forKey: "fontsize")
    setFontSize(size)
  }
  
  override func viewWillDisappear() {
    NSApplication.shared().terminate(self)
  }
  
  // Schriftgröße von txtfield ändern
  func setFontSize(_ size: Int) {
    txtfield.font = NSFont(
      descriptor: txtfield.font!.fontDescriptor,
      size: CGFloat(size))
    
    //    let oldfont:NSFont!
    //    let fontmanager = NSFontManager.shared()
    //    let newfont = fontmanager.convert(oldfont,
    //      toHaveTrait: .boldFontMask)
  }
  

  override func prepare(for segue: NSStoryboardSegue,
                        sender: Any?) {
    // println("prepareforsegue")
  }
}

