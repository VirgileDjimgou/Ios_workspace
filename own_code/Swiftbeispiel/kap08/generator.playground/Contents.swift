//: Playground - noun: a place where people can play

import Cocoa

// protocol Generator<Element> wäre logischer,
// wird von Swift aber nicht akzeptiert
protocol Generator {
  associatedtype Element
  mutating func next() -> Element?
}

// die Struktur MyGenerator implementiert das Generator-Protokoll
struct MyGenerator<T:IntegerArithmeticType> : Generator {
  typealias Element = T
  
  private var current:T
  private let end:T
  private let delta:T
  
  init(_ start:T, _ end:T, _ delta:T) {
    current = start
    self.end = end
    self.delta = delta
  }
  
  mutating func next() -> T? {
    let result = current
    if current>end {
      return nil
    } else {
      current += delta
      return result
    }
  }
}

// Test
var gen1 = MyGenerator(0, 10, 2)        // T = Int
while let x = gen1.next() {
  print(x)
}
// Ausgabe: 0, 2, 4, 6, 8, 10 (Datentyp Int)

var gen2 = MyGenerator<UInt8>(0, 10, 2) // T = UInt8
while let x = gen2.next() {
  print(x)
}
// Ausgabe: 0, 2, 4, 6, 8, 10 (Datentyp UInt8)
