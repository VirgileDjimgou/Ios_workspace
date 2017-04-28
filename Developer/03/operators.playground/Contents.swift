//: Playground - noun: a place where people can play

import Cocoa

// Leerzeichen vor und nach Operatoren
if true {
  var x: Int? = 3
  if(x != nil) {    // OK
    print("bla")
  }
  //  if(x!=nil) {  // Syntaxfehler, der Compiler glaubt, Sie meinen x! = nil
  //    print("bla")
  //  }
}

// Zuweisungen
if true {
  var (a, b, c) = (1, 7, 12)
  print(b)  // Ausgabe 7
}
if true {
  var (_, a, (b, c)) = (1, 2, ("x", "y"))
  print(b)  // Ausgabe "x"
  // entspricht var a=2; var b="x"; var c="y"
}

// Wert- und Referenztypen
if true {
  var x = 3
  var y = x
  x=4
  print(y)  // y ist unverändert 3

  class SimpleClass {
    var data=0
  }
  
  var a = SimpleClass()
  var b = a        // a und b zeigen auf die gleichen Daten
  a.data = 17
  print(b.data)    // deswegen ist auch b.data 17

}

// elementare Rechenoperatoren
if true {
  var a = 3       // a ist eine Integer-Variable
  var b = 1.7     // b ist eine Fließkommavariable
  // var c = a + b   // Fehler, Int-Wert + Double-Wert nicht zulässig
 
  var c1 = a + Int(b)     // c1 = 4
  var c2 = Double(a) + b  // c2 = 4.7
  
  // Division durch 0
  var x: Double = 2, y: Double = 0
  var z: Double = x/y
  print(z)
  if(z == Double.infinity) {
    print("bla")
  }
  
  // Integer-Arithmetik ohne Überlaufkontrolle
  var i = 10000000          // Integer
  var result = i &* i &* i  // falsches Ergebnis 3.875.820.019.684.212.736

  // Potenzieren
  var e = 7.0
  var f = pow(e, 3.0)  // 7 * 7 * 7 = 343.0

}

// Rechnen mit Bits
if true {
  let a = 0b11100                   // Wert 28
  let b = 0b01111                   // Wert 15
  let result = a & b                // Wert 12
  print(String(result, radix:2))    // Ausgabe 1100
  
  let e = 16
  let f = e << 2  // entspricht f=e*4, Ergebnis 64
  let g = e >> 1  // entspricht g=e/2, Ergebnis 8

  let rgb: UInt32 = 0x336688        // hexadezimaler Farbcode
  // Rot-Anteil extrahieren
  let red: UInt8  = UInt8( (rgb & 0xff0000) >> 16 )
}

// Vergleichsoperatoren
if true {
  1 == 2          // false
  1 < 2           // true
  "abc" == "abc"  // true
  "abc" == "Abc"  // false
  
  "A" < "a"       // true
  "a" < "ä"       // true
  "ä" < "b"       // true
}


// Testklasse, speichert X- und Y-Koordinate eines Punkts
class Pt {
  var x: Double, y: Double
  // Init-Funktion
  init(x: Double, y: Double){
    self.x=x
    self.y=y
  }
}

// globaler Operator, kann nicht innerhalb von if(...) formuliert werden
func ==(left: Pt, right: Pt) -> Bool {
  return left.x == right.x && left.y == right.y
}

var p1 = Pt(x: 1.0, y: 2.0)
var p2 = Pt(x: 1.0, y: 2.0)
p1 == p2    // true, weil die Objekte dieselben Daten enthalten
p1 === p2   // false, weil es unterschiedliche Objekte sind

// ~= Operator
if true {
  -2...2 ~= 1   // true
  -2...2 ~= -2  // true
  -2...2 ~= 2   // true
  -2...2 ~= 4   // false
  
  let n = 12
  switch n {
  case (1...10):
    print("Zahl zwischen 1 und 10")
    
  case(11...20):
    print("Zahl zwischen 11 und 20")
    
  default:
    print("Andere Zahl")
  }
}

// is-Operator
if true {
  func f(obj: Any) {
    if obj is UInt32 {
      print("Datentyp UInt32")
    } else {
      print("anderer Datentyp")
    }
  }
  f(obj: 12)        // Ausgabe 'anderer Datentyp'
  f(obj: Date())    // Ausgabe 'anderer Datentyp'
  let ui32: UInt32 = 47
  f(obj: ui32)      // Ausgabe 'Datentyp UIn32'
}

// as-Operator
if true {
  let x = 12 as Float
  
  func f(obj: Any) {
    if let myint = obj as? UInt32 {
      print(myint)
      // myint hat den Datentyp UInt32
      } else {
      print("falscher Datentyp")
    }
  }
  let ui = UInt32(integerLiteral: 123)
  f(obj: 123 as UInt32)
  
}

// logische Operatoren
if true {
  let a=3, b=5
  a>0 && b<=10             // true
  a>b || b>a               // true
  let ok = (a>b)           // false
  if !ok {                 // wenn ok nicht true ist, dann ...
    print("Fehlermeldung") // ... eine Fehlermeldung ausgeben
  }
}

// Range-Operatoren
if true {
  for i in 1...10 {
    print(i)
  }
  var ar = [Int](1...10)  // entspricht var ar = [1, 2, ..., 10]
  (1...5).map { print($0) }
  
  var r = 1..<10  // entspricht r=CountableRange<Int>(1..<10)
  r.startIndex    // 1
  r.endIndex      // 10
  r.contains(7)   // true
  r.contains(11)  // false
  
  1...10 ~= 8        // true
  1.7..<2.9 ~= 2.3   // true
  "a"..."z" ~= "f"   // true
  "0"..."9" ~= "x"   // false
  
  // nicht möglich, ClosedRange<String> does not
  //                conform to protocol Sequence
  //  for c in "a"..."z" {
  //    print(c)
  //  }
}

// termnärer Operator
if true {
  // if-Schreibweise
  var result:String
  let x = Int(arc4random())
  if x<10 {
    result = "x kleiner 10"
  } else {
    result = "x größer-gleich 10"
  }

  // verkürzte Schreibweise mit ternären Operator
  result = x<10 ? "x kleiner 10" : "x größer gleich 10"
}

// Unwrapping-Operator (Optionals)
if true {
  var x: Int? = 3    // x enthält eine ganze Zahl oder nil
  var y: Int! = 4    // y enthält eine ganze Zahl oder nil
  var z: Int  = 5    // z enthält immer eine ganze Zahl
  
  x = nil            // ok
  y = nil            // ok
  // z = nil         // nicht erlaubt
  
  x = 3              // x und y sind weiterhin
  y = 4              // Optionals
  var i: Int = x!    // explizites Unwrapping durch x!
  var j: Int = y     // automatisches Unwrapping

  // k den Wert von x oder den Defaultwert -1 zuweisen
  var k = x ?? -1    // der Datentyp von j ist Int

}

