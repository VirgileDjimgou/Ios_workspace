//: Playground - noun: a place where people can play

import Foundation

// Rechteckklasse
class RectangleClass {
  // zwei Eigenschaften bzw.
  // Klassenvariablen
  var length: Double
  var width: Double
  
  // Init-Funktion
  init(_ length: Double,
       _ width: Double)
  {
    self.length = length
    self.width = width
  }
  
  // Methode
  func getArea() -> Double {
    return length * width
  }
}

// Rechteckstruktur
struct RectangleStruct {
  // zwei Eigenschaften bzw.
  // Klassenvariablen
  var length: Double
  var width: Double
  
  // Init-Funktion
  init(_ length:Double,
       _ width:Double)
  {
    self.length = length
    self.width = width
  }
  
  // Methode
  func getArea() -> Double {
    return length * width
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

// Init-Funktionen
if true {
  struct Test {   // alle Eigenschaften sind initialisiert,
    // daher ist die Init-Funktion optional
    var a = 0
    var b = 1
    var c: Int?                    // automatisch nil
  }
  var t1 = Test()                  // a=0, b=1, c=nil
  var t2 = Test(a: 2, b: 3, c: 2)  // ruft Default-Init-Funktion auf
}

if true {
  struct Test {
    var a = 0
    var b = 1
    init(a: Int, b: Int)  {
      self.a = a
      self.b = b
    }
  }
  // die Parameternamen müssen angegeben werden!
  var t = Test(a: 2, b: 3)
}

if true {
  struct Test {
    var a = 0
    var b = 1
    // Init-Funktion mit unbenannten Parametern
    init(_ a: Int, _ b: Int)  {
      self.a = a
      self.b = b
    }
  }
  // die Parameter werden ohne Namen angegeben
  var t = Test(2, 3)

}

// Convenience-Init
if true {
  // Testklasse mit vier Eigenschaften
  class Test {
    var a: Int
    var b: Int
    var c: Double
    var d: String
    
    // Designated Init Function für alle Eigenschaften
    init(a: Int, b: Int, c: Double, d: String) {
      self.a = a
      self.b = b
      self.c = c
      self.d = d
    }
    
    // Convenience Init Function
    convenience init(c: Double) {
      // ruft die Designated Init Function auf
      self.init(a: 0, b: -1, c: c, d: "")
    }
  }
  
  // erzeugt eine Instanz mit Convenience Init Function
  var t = Test(c: 2.5)  // t.a=0, t.b=-1, t.c=2,5, t.d=""
}
