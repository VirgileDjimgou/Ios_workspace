//
//  MyVie.swift
//  osx-menu
//
//  Created by Michael Kofler on 07.05.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

// macht die View zum First Responder
class MyView: NSView {
  override var acceptsFirstResponder: Bool { return true }
  
  override func becomeFirstResponder() -> Bool {
    return true
  }
  override func resignFirstResponder() -> Bool {
    return true
  }
}
