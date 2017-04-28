//: Playground - noun: a place where people can play

import Cocoa

// Werttypen (Arrays sind in Swift Werttypen!)
let x = [1, 2, 3]  // x ist ein unveränderliches Array
var y = x          // y ist ein veränderliches Array
y.removeLast()     // letztes Element entfernen
x                  // enthält immer noch [1, 2, 3]
y                  // enthält [1, 2]

// Referenztypen (Klassen sind immer Referenztypen)
class MyClass {     // Definition einer minimalistischen Klasse
  var data = 10
}

var a = MyClass()   // a verweist auf ein Objekt
var b = a           // b verweist auf dasselbe Objekt
b.data = 3          // b wird verändert
a.data              // die Änderung gilt auch für a

// Beispiel für einen Referenztypen
let reg = NSRegularExpression()





























