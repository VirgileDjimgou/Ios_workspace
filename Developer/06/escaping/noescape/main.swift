//
//  main.swift
//  noescape
//
//  Created by Michael Kofler on 11.09.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import Foundation

// in Swift 3 gilt das ehemalige Attribut @noescape automatisch
// https://github.com/apple/swift-evolution/blob/master/proposals/0103-make-noescape-default.md

func callTwice(_ fn: () -> ()) {
  fn()
  fn()
}

func callTrice(_ fn:  @escaping () -> ()) {
  // nur mit @escaping erlaubt:
  let f = fn
  callTwice(f)
  f()
}

class MyClass {
  var somedata = 17
  func m() {
    // übergibt an callTrice() eine Closure,
    // die dreimal ausgeführt wird
    callTrice() {
      print(self.somedata)
    }
  }
}

let tst = MyClass()
tst.m() // Ausgabe: dreimal 17
