//: Playground - noun: a place where people can play

import UIKit

// count
if true {
  let ar = [1, 2, 3, 4, 5, 6]
  let s = "Hello World!"
  let rng = 1...10
  ar.count               // 6
  s.characters.count     // 12
  rng.count              // 10
}

// first und last
if true {
  var ar = [1, 2, 3, 4]
  var s = "Hello World!"
  ar.first           // 1, Datentyp Int?
  s.characters.last  // "!", Datentyp Character?
}

// prefix, suffix
if true {
  var ar = [1, 2, 3, 4]
  let sub1 = ar.prefix(2)      // [1, 2], Datentyp ArraySlice<Int>
  let sub2 = ar.suffix(2)      // [3, 4], Datentyp ArraySlice<Int>
  var x = [Int]()
  let sub3 = x.prefix(2)       // leer, weil auch x leer ist
}

// dropFirst und dropLast
if true {
  var ar = [1, 2, 3, 4]
  ar.dropFirst()     // [2, 3, 4], Datentyp [Int]
  ar.dropLast()      // [1, 2, 3], Datentyp [Int]
  var s = "Hello World!"
  String(s.characters.dropFirst())      // "ello World!"
  String(s.characters.dropLast())       // "Hello World" (ohne Rufezeichen)
}


// startsWith, contains und indexOf
if true {
  let ar = [1, 2, 3, 4, 5, 6]
  ar.startsWith([1, 2])       // true
  ar.startsWith([4, 5])       // false
  
  ar.contains(3)                 // true
  ar.contains( {$0 % 2 == 0} )   // true

  let data = Array(1...10)
  data.indexOf(7)                // 6, Datentyp Index?
  data.indexOf(12)               // nil
  data.indexOf( {$0 % 2 == 0} )  // 1, Datentyp Index?
}


// advance und distance
if true {
  2.distanceTo(7)  // Abstand von 2 nach 7:  5 (Datentyp Int)
  7.distanceTo(2)  // Abstand von 7 nach 2: -5
  2.advancedBy(5)   // von Position 2 um 5 Schritte weiter: 7
  
  let s = "Hello World!"
  let start = s.startIndex      // 0, Datentyp Index
                                // genaugenommen: String.CharacterView.Index, 
                                // wegen typealias Index = String.CharacterView.Index
  let end = s.endIndex          // 12, Datentyp Index
  
  // Position des ersten Leerzeichens ermitteln
  let pos1 = s.characters.indexOf(" ") ?? end
  pos1                          // 5, Datentyp Index
  // pos1 - start               // Fehler, - kann mit
  //                               Index nicht rechnen
  start.distanceTo(pos1)         // 5, Datentyp Int
  
  // zuerst ein Zeichen weiter, dann noch drei Zeichen
  let pos2 = pos1.advancedBy(1)   // 6, Datentyp Index
  let pos3 = pos2.advancedBy(3)   // 9, Datentyp Index
  s[pos2..<pos3]                  // "Wor", Datentyp String
  
  // let pos4 = start.advancedBy(100)  // löst Fehler aus
}

// split und join
if true{
  let data = [1, 2, 0, 5, 6, 4, 0, 0, 3, 0, 2]
  let splitted = data.split {$0==0}
  // Datentyp [ArraySlice<Int>], also ein Array von Slices
  splitted  // [[1, 2], [5, 6, 4], [3], [2]]
  
  let joined = splitted.joinWithSeparator([0])
  // Datentyp JoinSequence<Array<ArraySlice<Int>>>
  let newdate = Array(joined)  // [1, 2, 0, 5, 6, 4, 0, 0, 3, 0, 2]
  
  ["e4", "e5", "c7", "c6"].joinWithSeparator(";")
}



// filter, map und reduce
if true {
  var data1 = Array(1...100)
  
  func testNumber(x:Int) -> Bool {
    if x>10 && x<50 && (x % 3 == 0) {
      return true
    }
    return false
  }
  
  let result1 = data1.filter( { testNumber($0) } )
  result1     // [12, 15, 18, ..., 48]

  var data2 = [2, 5, 4]
  func f(n:Int) -> String {
    var result=""
    for _ in 1...n { result += "*" }
    return result
  }
  data2.map(f)  // ["**", "*****", "****"]
  
  var ar = [1, 2, 3]
  let nested = ar.map( { Array(1...$0) } )
  // nested = [[1], [1, 2], [1, 2, 3]]
  nested
  
  let flat = ar.flatMap( { Array(1...$0) } )
  // flat = [1, 1, 2, 1, 2, 3]
  flat

  
  let data3 = [0xff, 0xf0, 0x10]
  let result3 = data3.reduce(0xffff, combine: { $0 & $1 })
  String(result3, radix:16)  // Ergebnis hexadezimal "10"
}


// forEach
if true {
  let ar = [2.7, 3.9, 1.6]
  var sum = 0.0
  ar.forEach( { sum += $0} )
  print(sum)
  
  let s="abc"
  s.characters.forEach( { print($0) } )
  // Ausgabe: "a", "b", "c"
  
  // Hinweis: die Ausgabe ist in Xcode 7.0 + 7.1 im Playground nicht zu sehen;
  // wenn Sie den Code in einem kompilierten Programm ausführen, funktioniert
  // er wunschgemäß; hier liegt offensichtlich ein Bug in Xcode vor
  
  (65...68).forEach()
    { print( UnicodeScalar($0), terminator:"") }
  print("")
  // Ausgabe "ABCD", siehe Hinweis oben
  
  let data = Array(1...20)
  data.filter( {$0 % 3 == 0} )
    .map( {$0*$0} )
    .forEach( { print($0) } )
  // Ausgabe: 9, 36, 81, 144, 225, 324, siehe Hinweis oben
}


// sort und reverse
if true {
  let s = "Hello World!"
  String(s.characters.reverse())  // "!dlroW olleH"
  String(s.characters.sort(<))    // " !HWdellloor"

  var ar = [7, 3, 12, 2]
  ar.sortInPlace(<)
  print(ar)                       // [2, 3, 7, 12]
}
