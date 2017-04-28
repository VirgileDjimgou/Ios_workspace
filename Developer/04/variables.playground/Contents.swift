//: Playground - noun: a place where people can play

import Cocoa

// Variablen
if true {
  var x = 3           // implizite Integer-Variable
  x = 5               // OK
  // x = 1.4          // Fehler, x ist eine Fließkommazahl
  
  var y: Double = 3   // explizite Double-Variable
  y = 1.7             // OK
  
  var a = 3, b = 8.4, c = false
  var d, e, f: Double, g: Bool
  // print(d)        // Fehler, d ist nicht initialisiert
}

// zulässige Variablennamen
if true {
  var äöü = 3     // OK
  var _xyz = 4    // OK
  var _123 = 5    // OK
  var `for` = 6   // OK
  // var a b = 3     // Fehler, keine Leerzeichen
  // var `a b` = 3   // Fehler, keine Leerzeichen
  // var 1abc = 3    // Fehler, Name darf nicht mit Ziffer beginnen
  // var $abc = 3    // Fehler, $ ist nicht erlaubt
  // var ef.gh = 3   // Fehler, . ist nicht erlaubt

}

// Konstanten
if true {
  let max = 5    // Konstante
  // max = 7     // Fehler, Max kann nicht mehr verändert werden

  let c: String  // in c soll der Name einer Farbe gespeichert werden
  if arc4random() % 2 == 0 {
    c = "Red"
  } else {
    c = "Green"
  }
  
  // eine ganz einfache Klasse
  class MyClass {
    var data: Double
    init(data: Double) {
      self.data = data
    }
  }
  
  let obj = MyClass(data: 2)  // obj.data enthält 2.0
  // obj = MyClass(data: 7)   // Fehler, obj ist eine Konstante
  obj.data = 5                // OK, obj.data ist jetzt 5.0

  var s: String = "blabla"    // Zeichenkette
  if let x = Int(s) {         // sofern s eine Zahl enthält, 
                              // hat x hat den Datentyp Int
    print(x)
  }

}

// Computed Properties
if true {
  var s: String = "123"  // normale Variable, Datenspeicher
  var x: Int {           // Computed Property
    get {
      // der Wert von s oder 0, wenn s keine Zahl enthält
      return Int(s) ?? 0
    }
    set {
      s = "\(newValue)"
    }
  }
  x       // 123
  x = 35  // s wird damit "35" zugewiesen
  s
  s = "abc"
  x       // 0, weil "abc" keine Zahl ist

}

if true {
  enum Color {
    case white
    case black
    case red, green, blue
  }
  
  var c = Color.white
  if c == .red {
    print("c enthält die Farbe 'rot'.")
  }
  
  // Kurzschreibweise
  c = .green      // c ist eine Variable vom Typ 'Color'
  if c == .green {
    print("grün")
  }

  // Syntaxfehler, hier müssen Lerrzeichen vor und nach 
  // = bzw. == gesetzt werden
  // c=.green
  // if c==.green { print("bla") }
  
  // zufällig rot oder weiß einstellen
  c = arc4random() % 2 == 0 ? .red : .white
  
  // Enumerationen in switch-Ausdrücken
  switch c {
  case .green:
    print("grün")
  case .white, .black:
    print("schwarz/weiß")
  default:
    print("andere farbe")
  }

  
  

}

// rawValues, Enumeration mit String-Datentyp
if true {
  enum Color: String {
    case red  = "ff0000"
    case blue = "0000ff"
  }
  var c = Color.red
  c.rawValue         // "ff0000"
}

// automatische rawValues (Int-Datentyp)
if true {
  enum Color: Int {
    case red = 4, blue, green
    case black = 10, white
  }
  
  Color.green.rawValue  // 6
  Color.white.rawValue  // 11

}

// automatische rawValues (String-Datentyp)
if true {
  enum Color : String {
    case white
    case black
    case red, green, blue
  }
  
  Color.green.rawValue  // "green"
}

// ohne Datentyp keine rawValues 
if true {
  enum Color {
    case red
    case blue
  }
  var c = Color.red
  // c.rawValue           // Fehler
  // Color.blue.rawValue  // Fehler
}
