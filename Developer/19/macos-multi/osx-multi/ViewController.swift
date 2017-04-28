//
//  ViewController.swift
//  osx-multi
//
//  Created by Michael Kofler on 02.05.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

  @IBOutlet weak var txtfield: NSTextField!
  
  var win2array:[NSWindowController] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  // Datenübergabe an den Zielcontroller
  override func prepare(for segue: NSStoryboardSegue,
                        sender: Any?)
  {
    if let dest = segue.destinationController as? Window2VC {
      dest.data = txtfield.stringValue
    }
  }
  
  // anderes Fenster per Segue öffne
  @IBAction func btnOpen(_ sender: NSButton) {
    performSegue(withIdentifier: "SegueToAnother", sender: self)
  }
  
  // anderes Fenster ohne Segue erzeugen
  @IBAction func btnOpen2(_ sender: NSButton) {
    if let winctrl = storyboard!
      .instantiateController(withIdentifier: "w2vc")
      as? NSWindowController
    {
      if let w2vc = winctrl.contentViewController as? Window2VC {
        // w2vc.label.stringValue =  txtfield.stringValue
        w2vc.data =  txtfield.stringValue
      }
      winctrl.showWindow(self)
      win2array.append(winctrl)  // sonst sofort wieder weg!
    }
  }
  
  // Programmende
  @IBAction func btnEnd(_ sender: NSButton) {
    NSApplication.shared().terminate(self)
  }
  override func viewDidDisappear() {
    NSApplication.shared().terminate(self)
  }
}

