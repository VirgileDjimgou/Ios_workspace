//
//  main.swift
//  lazy-properties
//
//  Created by Michael Kofler on 10.07.15.
//  Copyright © 2015 Michael Kofler. All rights reserved.
//

import Foundation

// Beispiel 1: Lazy Properties
func complicatedCalc() -> Double {
  print("calc")
  return 3.0
}

struct MyData {
  var a = 1.0
  var b = 2.0
  lazy var c = complicatedCalc()
}

var md = MyData()
print(md.a)
print(md.b)
print(md.c)  // erst jetzt wird complicatedCalc() ausgeführt

// Ausgabe: 1,0
//          2,0
//          calc
//          3,0


// Beispiel 2: Closures für Lazy Properties

class MyClass {
  var a:Double
  var b:Double
  // c wird erst bei Bedarf durch die Auswertung
  // der folgenden Closure initialisiert
  lazy var c:Double = { self.m() }()
  
  init() {
    a=2; b=3
  }
  
  func m() -> Double {
    return sqrt(a+b)
  }
}

let mc = MyClass()
print(mc.c)  // 2,2361
