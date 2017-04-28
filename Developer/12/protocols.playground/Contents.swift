//: Playground - noun: a place where people can play

import Foundation

class SuperClass { }
protocol Protocol1 { }
protocol Protocol2 { }
protocol Protocol3 { }

struct MyStruct : Protocol1, Protocol2, Protocol3 {  }
enum MyEnum     : Protocol1, Protocol2, Protocol3 {  }
class MyClass1  : Protocol1, Protocol2, Protocol3 {  }
class MyClass2  : SuperClass, Protocol1, Protocol2, Protocol3 {  }

protocol P4 : Protocol1, Protocol2, Protocol3 {  }

protocol P5 {
  // Methoden
  func m1(a: Int) -> String       // gewöhnliche Methode
  static func m2() -> Double      // statische Methode
  mutating func m3(p: Int)        // Mutating Method
  
  // Eigenschaften
  var p1: Int {get set}           // gewöhnliche Eigenschaft
  var p2: String {get}            // Konstante bzw. read-only
  static var p3: Double {get set} // statische Eigenschaft
  
  // Init-Funktionen
  init(x: Int, y: Bool)          // gewöhnliche Init-Funktion
  init?(z: Double)               // Failable Init Function
}

protocol P6 : class {
  func m()
  var p: Double {get set}
}

protocol P7 {
  // die Funktion m gibt als Ergebnis eine Instanz
  // der Enumeration, Struktur oder Klasse zurück,
  // die das Protokoll implementiert
  func m() -> Self
}

var x: P4 & P5 & P6




//: Any, AnyObject, AnyClass


func f1(_ all: Any ...) {
  for p in all {
    if let i = p as? Int {
      print("  Integer: \(i)")
    } else if let d = p as? Double {
      print("  Double: \(d)")
    } else if let s = p as? String {
      print("  String: \(s)")
    } else {
      print("  Sonstige: \(type(of: p))")
    }
  }
}


// Test
class MyClass {}
f1(8, 2.5, "abc", false, Date(), MyClass())
// Ausgabe: Integer: 8
//          Double: 2.5
//          String: abc
//          Sonstige: Bool
//          Sonstige: Date
//          Sonstige: MyClass


let any : AnyObject = 123 as AnyObject

// die Variable t speichert hier
// den Typ der Klasse 'MyClass'
var aType: AnyClass = MyClass.self
