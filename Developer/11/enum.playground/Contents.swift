//: Playground - noun: a place where people can play

import UIKit

// Hello Enumeration
if true {
  enum Color {
    case white, black, red, green, blue
    init() {
      self = .white      // Weiß ist die Default-Farbe
    }
  }
  
  var c1 = Color()      // diese beiden Anweisungen
  var c2 = Color.white  // sind gleichwertig
}

// Enums mit Init-Funktion und rawValues
if true {
  enum Color : Int {
    case white = 1
    case black = 2
    case red = 3
  }
  
  let c = Color.black
  
  if c == Color.black { print("schwarz") }  // OK
  if c.rawValue == 2  { print("schwarz") }  // OK
  // if c == 2           { print("schwarz") }  // Fehler
}

// Enums können Protokolle implementieren
if true {
  enum MyErrors : Error {
    case tooSmall
    case tooBig(maximum: Int)
    case missing
    case other(explanation: String)
  }
}

// Enums mit Associated Values
if true {
  enum Token {
    case `operator`(String)
    case number(Int)
    case text(String)
  }
  
  var stack = [Token]()   // ein Array von 'Token'-Elementen
  stack.append(Token.text("abc"))
  stack.append(Token.number(123))
  stack.append(Token.operator("+"))

  for data in stack {
    switch data {
    case let .operator(op):
      print("Operator: \(op)")
    case let .number(n):
      print("Number: \(n)")
    case let .text(t):
      print("Text: \(t)")
    }
  }

  let t = Token.operator("+")
  //  if t == Token.operator {  // Fehler
  //    print("bla")
  //  }
  //  if t == Token.operator("+") {  // auch Fehler
  //    print("bla")
  //  }
}
