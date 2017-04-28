//
//  LottoWindowController.swift
//  osx-lotto-xib-windowcontroller
//
//  Created by Michael Kofler on 02.05.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

class LottoWindowController: NSWindowController, NSWindowDelegate {
  @IBOutlet weak var radioDeutsch: NSButton!
  @IBOutlet weak var radioÖsterr: NSButton!
  @IBOutlet weak var txt1: NSTextField!
  @IBOutlet weak var txt2: NSTextField!
  @IBOutlet weak var txt3: NSTextField!
  @IBOutlet weak var txt4: NSTextField!
  @IBOutlet weak var txt5: NSTextField!
  @IBOutlet weak var txt6: NSTextField!
  
  var lotto:Lotto!
  
  // Initialisierung
  override func windowDidLoad() {
    super.windowDidLoad()
    lotto = Lotto(count: 6, max: 49)
    newNumbers()
    self.window?.delegate = self
  }

  // Programmende beim Schließen des Fensters
  func windowWillClose(_ notification: Notification) {
    NSApplication.shared().terminate(self)
  }
  
  
  // einer der beiden Radio-Buttons wurde angeklickt
  @IBAction func changeSystem(_ sender: NSButton) {
    if sender === radioDeutsch {
      lotto = Lotto(count: 6, max: 49)
    } else {
      lotto = Lotto(count: 6, max: 45)
    }
    newNumbers()
  }
  
  // Button 'Noch ein Tipp' wurde angeklickt
  @IBAction func btnAgain(_ sender: AnyObject) {
    newNumbers()
  }
  
  // neue Lottozahlen erzeugen und in den Textfeldern anzeigen
  func newNumbers() {
    let nmbs = lotto.generateNumbers()
    txt1.stringValue = "\(nmbs[0])"
    txt2.stringValue = "\(nmbs[1])"
    txt3.stringValue = "\(nmbs[2])"
    txt4.stringValue = "\(nmbs[3])"
    txt5.stringValue = "\(nmbs[4])"
    txt6.stringValue = "\(nmbs[5])"
  }
}
