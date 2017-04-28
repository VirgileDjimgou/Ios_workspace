//
//  main.swift
//  try-catch
//
//  Created by Michael Kofler on 21.07.15.
//  Copyright © 2015 Michael Kofler. All rights reserved.
//

import Foundation

enum MyErrors : ErrorType {
  case TooSmall
  case TooBig(maximum:Int)
  case Missing
  case Other(explanation:String)
}

// f1, f2 und f3 können Fehler auslösen
func f1(n:Int) throws -> Int {
  if n<0   { throw MyErrors.TooSmall }
  if n>100 { throw MyErrors.TooBig(maximum: 100) }
  return n+1
}
func f2(n:Int?) throws  -> Int {
  if n == nil { throw MyErrors.Missing }
  return n! + 1
}

// f3 gibt Fehler, die in f1 oder f2 evt.
// auftreten, einfach weiter
func f3() throws -> Int {
  return try f1(101) + f2(88)
}

// f4 zeigt die Anwendung von guard
func f4(n:Int?) throws -> Int {
  guard let a = n where n>=0 && n<=100  else {
    throw MyErrors.Other(explanation: "ungültiger Parameter")
  }
  return a * 2
}

// zeigt, wie doppelte Optionals entstehen können
func f5(n:Int) throws -> Int? {
  if n<0   { return nil }
  if n>100 { throw MyErrors.TooBig(maximum: 100) }
  return n+1
}


// Funktionen f1 bis f5 aufrufen
func test()  {
  do {
    let a = try f1(101)
    let b = try f2(a)
    let c = a / (a-6)  // kann nicht abgesichert werden
    try print(12 + f1(1) +  f2(7) + f3())
    try f4(1)
    print(b+c)
  }
    // für den Fehler .TooSmall
  catch MyErrors.TooSmall {
    print("Fehler: Parameter zu klein")
  }
    // für den Fehler .TooBig
  catch MyErrors.TooBig(let maximum) {
    print("Fehler: Parameter zu groß")
    print("Maximalwert = \(maximum)")
  }
  
    // für alle MyErrors-Fehler
  catch let myerror as MyErrors {
    switch myerror {
    case .TooSmall:
      print("Parameter zu klein")
    case let .TooBig(n):
      print("Parameter zu groß, Maximum=\(n)")
    case .Missing:
      print("Parameter darf nicht nil sein")
    case let .Other(msg):
      print("Anderer Fehler: \(msg)")
    }
  }
    // für alle anderen Fehler
  catch {
    let nserr = error as NSError
    print("Fehlerbeschreibung: \(nserr.description)")
  }
  // Alternative: Default-catch mit integriertem NSError-Casting
  //catch let nserr as NSError {
  //  print("Fehlerbeschreibung: \(nserr.description)")
  //}
  
  print("Hier geht es weiter, wenn kein Fehler " +
    "oder ein abgesicherter Fehler aufgetreten ist.")
  
  
  var result1 = try? f1(10)  // Datentyp Int?
  print(result1)             // Ausgabe Optional(11)
  result1 = try? f1(1000)
  print(result1)             // Ausgabe nil
  
  let result5 = try? f5(10)  // Datentyp Int??
  if let n = result5 {       // Datentyp Int?
    if let m = n {           // Datentyp Int
      print(m)               // Ausgabe nil
    }
  }
}

// Test-Code ausführen
test()

// sonstiges

//print(MyErrors.TooSmall._code)     // 0
//print(MyErrors.TooSmall._domain)   // try_catch.MyErrors

//print("")
//let nserr = MyErrors.TooBig(maximum: 1000) as NSError
//print(nserr.userInfo)  // leer, also [:]
//print(nserr)           // Fehlerbeschreibung, aber ohne die Info maximum:1000

