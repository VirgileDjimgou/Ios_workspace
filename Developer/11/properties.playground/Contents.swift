//: Playground - noun: a place where people can play

import UIKit

struct Person {
  var name: String
  var address: String
  var telnr: [String]
  
  func showData() {
    print("Name:    \(name)")
    print("Adresse: \(address)")
    print("Tel.nr.: \(telnr)")
  }
}

var p = Person(name: "Michael", address: "Graz",
               telnr: ["0043 676 98765432", "0043 316 98765432"])

// Property Observer
var percent: Double = 0.5  {
didSet  {
  percent = max(0.0, min(1.0, percent))
}
}
percent = 1.3
percent   // Ausgabe 1!

// statische Eigenschaften
struct MyData {
  var a = 1.0
  static var b = 2.0
}

var md = MyData()
md.a         // OK, 1,0
MyData.b     // OK, 2,0
// md.b      // Fehler!

class SingletonClass {
  static let shared = SingletonClass()
}
let sc = SingletonClass.shared

// Read-Only-Eigenschaften
var pi: Double {
  return 3.1415   // liefert ein Ergebnis
}
private(set) var pi2: Double = 3.1415 / 2


class Counter {
  private(set) var counter:Int = 0
  func increment() {
    self.counter = self.counter + 1
  }
}

var c = Counter()
c.increment()
print(c.counter)  // 1
c.increment()
print(c.counter)  // 2
// c.counter = 10    // Fehler, nicht erlaubt