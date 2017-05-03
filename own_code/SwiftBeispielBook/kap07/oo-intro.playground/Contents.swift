//: Playground - noun: a place where people can play

import Foundation

// Rechteckklasse
class RectangleClass {
  // zwei Eigenschaften bzw.
  // Klassenvariablen
  var length:Double
  var width:Double
  
  // Init-Funktion
  init(_ length:Double,
    _ width:Double) {
      self.length = length
      self.width = width
  }
  
  // Methode
  func getArea() -> Double {
    return length*width
  }
}

// Rechteckstruktur
struct RectangleStruct {
  // zwei Eigenschaften bzw.
  // Klassenvariablen
  var length:Double
  var width:Double
  
  // Init-Funktion
  init(_ length:Double,
    _ width:Double) {
      self.length = length
      self.width = width
  }
  
  // Methode
  func getArea() -> Double {
    return length*width
  }
}


// Anwendung der Klasse
let r1 =
RectangleClass(12, 10)
r1.length = 13
r1.width
r1.getArea()  // 130.0
let r2 = r1   // Referenz

// Anwendung der Struktur
let r3 = RectangleStruct(4.3, 2.5)
r3.getArea()
let r4 = r3
