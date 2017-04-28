//: Playground - noun: a place where people can play

import Cocoa

let datetype = Date.self     // speichert Datentyp Foundation.Date.Type
let d1 = datetype.init()     // erzeugt ein Date-Objekt
print("Aktuelles Datum und Uhrzeit: \(d1)")

let mytype = NSClassFromString("NSDate") as! NSObject.Type
let d2 = mytype.init()         // erzeugt ein NSDate-Objekt
print("Aktuelles Datum und Uhrzeit: \(d2)")


class A { }     // Basisklasse A
class B: A {    // B ist von A abgeleitet
  func m() { print("bla") }
}
let myvar: A = B()             // myvar hat den Datentyp A, enthält aber eine Instanz vom Typ B
let type1 = A.self             // Datentyp A.Type
let type2 = B.self             // Datentyp B.Type
let type3 = type(of: myvar)    // Datentyp B.Type
if type(of: myvar) == B.self {
  print("myvar enthält eine Instanz von B.")
}

// Typ versus Metatyp
let a = A()
let b = B()
a.self       // A
b.self       // B
let c:A = B()
c.self       // auch B
type(of: a)  // A.Type
type(of: b)  // B.Type
type(of: c)  // B.Type