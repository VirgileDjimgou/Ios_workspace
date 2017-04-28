//
//  main.swift
//  try-catch

import Foundation


enum MyErrors : Error {
  case tooSmall
  case tooBig(maximum: Int)
  case missing
  case other(explanation: String)
}



// f1, f2 und f3 können Fehler auslösen
func f1(_ n: Int) throws -> Int {
  if n < 0   { throw MyErrors.tooSmall }
  if n > 100 { throw MyErrors.tooBig(maximum: 100) }
  return n + 1
}
func f2(_ n:Int?) throws  -> Int {
  if n == nil { throw MyErrors.missing }
  return n! + 1
}

// f3 gibt Fehler, die in f1 oder f2 evt.
// auftreten, einfach weiter
func f3() throws -> Int {
  return try f1(101) + f2(88)
}

// f4 zeigt die Anwendung von guard
func f4(_ n:Int?) throws -> Int {
  guard let a = n , a >= 0, a <= 100  else {
    throw MyErrors.other(explanation: "ungültiger Parameter")
  }
  return a * 2
}

// zeigt, wie doppelte Optionals entstehen können
func f5(_ n: Int) throws -> Int? {
  if n < 0   { return nil }
  if n > 100 { throw MyErrors.tooBig(maximum: 100) }
  return n + 1
}


// Funktionen f1 bis f5 aufrufen
func test()  {
  do {
    let a = try f1(101)
    let b = try f2(a)
    let c = a / (a - 6)  // kann nicht abgesichert werden
    try print(12 + f1(1) +  f2(7) + f3())
    try _ = f4(1)
    print(b + c)
  }
    
  catch MyErrors.tooSmall {
    // für den Fehler .TooSmall
    print("Fehler: Parameter zu klein")
  }
    
  catch MyErrors.tooBig(let maximum) {
    // für den Fehler .TooBig
    print("Fehler: Parameter zu groß")
    print("Maximalwert = \(maximum)")
  }
    
    //  catch let myerror as MyErrors {
    //    // Alternative: alle MyErrors-Fehler auf einmal
    //    switch myerror {
    //    case .tooSmall:
    //      print("Parameter zu klein")
    //    case let .tooBig(n):
    //      print("Parameter zu groß, Maximum=\(n)")
    //    case .missing:
    //      print("Parameter darf nicht nil sein")
    //    case let .other(msg):
    //      print("Anderer Fehler: \(msg)")
    //    }
    //  }
    
    
    
  catch {
    // für alle anderen Fehler
    print(error)
    print(error.localizedDescription)
    let nserr = error as NSError
    print("Fehlerbeschreibung: \(nserr.description)")
  }
  
  //  // Alternative: Default-catch mit integriertem NSError-Casting
  //  catch let nserr as NSError {
  //    print("Fehlerbeschreibung: \(nserr.description)")
  //  }
  
  //  // Alternative: Default-catch ohne Auswertung der error-Daten
  //  catch _ {
  //    print("Irgendein Fehler ...")
  //  }
  
  print("Hier geht es weiter, wenn kein Fehler " +
    "oder ein abgesicherter Fehler aufgetreten ist.")
  
  
  var result1 = try? f1(10)  // Datentyp Int?
  print(result1 as Any)      // Ausgabe Optional(11)
  result1 = try? f1(1000)
  print(result1 as Any)      // Ausgabe nil
  
  if let result = try? f1(50) {
    // result ist hier eine Int-Variable
    print("Ergebnis \(result)")
  }
  
  let result5 = try? f5(1000)  // Datentyp Int??
  if let n = result5 {         // Datentyp Int?
    if let m = n {             // Datentyp Int
      print("Ergebnis \(m)")
    } else {
      print("f5 hat nil zurückgegeben.")
    }
  } else {
    print("f5 hat einen Fehler ausgelöst.")
  }
  
  if let tmp = try? f5(60),
     let result = tmp
  {
    print("Ergebnis \(result)")
  }
}

// Test-Code ausführen
test()


// Sonstiges

print("---------")

//// error als NSError interpretieren
//let nserr = MyErrors.tooSmall as NSError
//print(nserr.description)  // Error Domain=try_catch.MyErrors Code=0 "(null)"
//print(nserr.userInfo)     // leer, also [:]

//let nserr = MyErrors.tooBig(maximum: 1000) as NSError
//print(nserr.userInfo)  // leer, also [:]



// -----------------------

// eigene Error-Struktur mit mehr Daten

//struct DetailedError : Error {
//  enum ErrorKind {
//    case tooSmall
//    case tooBig(maximum: Int)
//    case missing
//    case other(explanation: String)
//  }
//  let kind: ErrorKind
//  let contextinfo1: String
//  let contextinfo2: Int
//
//}
// throw DetailedError(kind: .tooSmall, contextinfo1: "bla", contextinfo2: 42)




// eigene Error-Klasse mit eigener Definition von
// localizedDescription, funktioniert nicht

//class DetailedError : Error {
//  enum ErrorKind {
//    case tooSmall
//    case tooBig(maximum: Int)
//    case missing
//    case other(explanation: String)
//  }
//  let kind: ErrorKind
//  let contextinfo1: String
//  var contextinfo2: Int
//  
//  init(kind: ErrorKind, context1: String, context2: Int) {
//    self.kind = kind
//    contextinfo1 = context1
//    contextinfo2 = context2
//  }
//  
//  // wird ignoriert
//  var localizedDescription: String {
//    return "bla"
//  }
//}
//
//func testDetailError() throws {
//  print("bla")
//  throw DetailedError(kind: .missing, context1: "bla", context2: 2)
//}
//
//do {
//  try testDetailError()
//}
//catch  {
//  print(error)
//  print(error.localizedDescription)  // "The operation couldn’t be completed. (try_catch.DetailedError error 1.)"
//}

// assert

//func mysqrt(_ x: Double) -> Double {
//  assert(x>=0, "x must be greater than 0")
//  return sqrt(x)
//}
//
//print(mysqrt(-1))  // Testbetrieb: löst Fehler aus
//// Release: Ausgabe 'nan'

// API

var s = "Hello World!"
do {
  try s.write(toFile: "/bla/test.txt",
              atomically: true,
              encoding: .utf8)
} catch let nserr as NSError {
  print("Fehler beim Speichern: \(nserr.localizedFailureReason)")
}



do {
  try s.write(toFile: "/bla/test.txt",
              atomically: true,
              encoding: .utf8)
} catch _ { }

try? s.write(toFile: "/bla/test.txt",
             atomically: true,
             encoding: .utf8)
