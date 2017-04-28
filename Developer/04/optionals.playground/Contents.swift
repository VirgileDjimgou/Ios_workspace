//: Playground - noun: a place where people can play

import Cocoa


// Hello Optionals!
if true {
  var op1: Int?      // Optional für Int
  var op2: Double!   // Optional für Double
  
  print(op1 as Any)  // Ausgabe "nil"
  // print(op2)      // Fehler 'unexpectedly found nil
                     // while unwrapping an Optional value'
  if op2 == nil {
    print("op2 ist nil")
  }
  
  op1 = 3            // erst jetzt haben die Optionals
  op2 = 1.4          // einen richtigen Wert
  
  print(op1 as Any)  // Optional(3)
  print(op2)         // 1.4
  
  let s = "123"
  var i = Int(s)     // i hat den Datentyp 'Int?'
  print(i as Any)    // Ausgabe "Optional(123)"
  print(i!)          // Ausgabe "123"
  i = Int("bla")
  print(i as Any)    // Ausgabe "nil"
  // print(i!)       // Fehler
}

// Optionals auslesen
if true {
  var op1: Int? = 1
  // print(op1 + 3)    // Fehler, 'Int' + 'Int?' ist nicht zulässig
  // let i: Int = op1  // Fehler, 'Int' = 'Int?' ist nicht möglich
  print(op1! + 3)      // ok
  let i: Int = op1!    // ok
  
  var op2: Double! = 1.4
  print(op2 + 1.7)     // ok
  let x: Double = op2  // ok
  
  let n: Int! = Int("abc")  // n enthält nun nil
}

// nil-Test
if true {
  let inputString = "7"
  let n = Int(inputString)   // n hat den Datentyp Int?
  if n == nil {
    print("Fehler, die Eingabe kann nicht in " +
      "eine Zahl umgewandelt werden.")
  } else {
    for i in 5...n! {
      print(i)  // Ausgabe: 5, 6, 7
    }
  }
}

// eleganter mit if let
if true {
  let inputString = "7"
  if let n = Int(inputString)  {  // n hat den Datentyp Int
    for  i in 5...7 {
      print(i)
    }
  }
}

// Nil Coalescing
if true {
  var i: Int
  let inputString = "123"
  let defaultvalue = 0
  let n = Int(inputString)
  
  // Variante 1
  if n == nil {
    i = defaultvalue
  } else {
    i = n!
  }

  // Variante 2 mit dem ternären Operator
  i = (n == nil) ? defaultvalue : n!
  
  // Variante 3 mit Nil-Coalescing-Operator
  i = n ?? defaultvalue
}
