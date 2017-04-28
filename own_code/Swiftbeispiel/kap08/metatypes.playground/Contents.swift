//: Playground - noun: a place where people can play

import Cocoa

let datetype = NSDate.self     // speichert Datentyp NSDate.Type
let d1 = datetype.init()       // erzeugt ein NSDate-Objekt
print("Aktuelles Datum und Uhrzeit: \(d1)")

let mytype = NSClassFromString("NSDate") as! NSObject.Type
let d2 = mytype.init()         // erzeugt noch ein NSDate-Objekt
print("Aktuelles Datum und Uhrzeit: \(d2)")


class A { }                    // Basisklasse A
class B: A {
  func m() { print("bla") }
}                 // B ist von A abgeleitet

let myvar:A = B()              // Datentyp A
let type1 = A.self             // Datentyp A.Type
let type2 = B.self             // Datentyp B.Type
let type3 = myvar.dynamicType  // Datentyp A.Type
let anothervar = myvar.self    // Datentyp A, entspricht let anothervar = myvar
let thirdvar = myvar
anothervar === thirdvar        // true


