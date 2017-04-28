//: Playground - noun: a place where people can play

import UIKit

()                // leeres Tupel
(1, 2, 3)         // Tupel aus drei Integer-Zahlen
(7, 3.234, "abc") // Tupel aus drei unterschiedlichen Datentypen

let t = (1, "abc", 3.14159)
t.0               // 1
t.1               // "abc"
t.2               // 3.14159

let u = (nr:1, txt:"abc", nmb:3.14159)
u.nr              // 1
u.txt             // "abc"

var t1: (Int, String, Double)
var t2: (nr: Int, txt: String, nmb: Double)
t1 = (1, "xx", 2.3)
// t2 = (nr: 1, txt: 2, nmb: 3)  // Fehler, entspricht nicht
                                 // den Datentypen

func minMax(_ data: [Int]) -> (min: Int?, max: Int?) {
  if data.isEmpty {
    return (nil, nil)
  }
  
  var min = data.first!, max = data.first!
  for itm in data {
    if itm < min { min = itm }
    if itm > max { max = itm }
  }
  
  return (min, max)
}

// minMax ausprobieren
let ar = [2, 7, 4, -2, 5]
let ergebnis = minMax(ar)     // (-2, 7)
ergebnis.min                  // -2
ergebnis.max                  // 7
let (a, b) = minMax(ar)
b                             // 7

// Tupel in switch-Konstruktionen
var pt = (0.0, 0.0)
switch pt {
case (0, 0):
  print("Koordinatenursprung")
  
case (_, 0):
  print("Auf der X-Achse")
  
case (0, _):
  print("Auf der Y-Achse")
  
case (-1.0...1.0, -1.0...1.0):
  print("Nahe dem Koordinatenursprung")
  
default:
  print("Sonstwo")
}

(1, 2, 3) == (1, 2, 3)  // true
(1, 2) == (2, 1)        // false
(1, 2) != (1, 1)        // true