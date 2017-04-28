//: Playground - noun: a place where people can play

import Foundation

// Struktur zur Speicherung eines Rechtecks
struct Rectangle {
  var length:Double
  var width:Double
  
  // Failable Init Function
  init?(_ length:Double, _ width:Double) {
    if length<=0 || width<=0 { return nil }
    self.length = length
    self.width = width
  }
}

// Beispiel 1: ein korrektes Rechteck
if var r1 = Rectangle(1.2, 2.4)  {
  print(r1.length)
  r1.length = 2.7
}

// Beispiel 2: in fehlerhaftes Rechteck
if var r2 = Rectangle(-1.2, 2.4)  {
  // dieser Code wird nicht ausgeführt,
  // weil Rectangle(-1.2, 2.4) nil
  // zurückgibt
  print(r2.length)
  r2.length = 2.7
}


