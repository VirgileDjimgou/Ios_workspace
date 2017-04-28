//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// first, last, prefix, suffix
if true {
  let ar = [1, 2, 3, 4]
  let s = "Hello World!"
  ar.first           // 1, Datentyp Int?
  s.characters.last  // "!", Datentyp Character?
  
  let sub1 = ar.prefix(2)      // [1, 2], Datentyp ArraySlice<Int>
  let sub2 = ar.suffix(2)      // [3, 4], Datentyp ArraySlice<Int>
  var x = [Int]()
  let sub3 = x.prefix(2)       // leer, weil auch x leer ist
  
  let new1 = ar.dropFirst()     // [2, 3, 4], Datentyp [Int]
  let new2 = new1.dropLast(2)   // [2], Datentyp [Int]
  
  String(s.characters.dropFirst())   // "ello World!"
  String(s.characters.dropLast())    // "Hello World"
}

// starts und contains
if true {
  let ar = [1, 2, 3, 4, 5, 6]
  ar.starts(with: [1, 2])       // true
  ar.starts(with: [4, 5])       // false
  
  ar.contains(3)                 // true
  ar.contains() {$0 % 2 == 0}    // true
}

// index
if true {
  let data = Array(1...10)
  data.index(of: 7)             // 6, Datentyp Index?
  data.index(of: 12)            // nil
  data.index() {$0 % 2 == 0}    // 1, Datentyp Index?
}

// filter
if true {
  let txt =
    "Lorem ipsum dolor sit amet, consetetur sadipscing elitr."
  let ar1 = txt.components(separatedBy: " ")
  let ar2 = ar1.filter() {$0.characters.count > 5}
  print(ar2)   // ["consetetur", "sadipscing", "elitr."]

  func testNumber(_ x: Int) -> Bool {
    return x>10 && x<50 && (x % 3 == 0)
  }
  
  var data = Array(1...100)
  let result = data.filter() { testNumber($0) }
  result     // [12, 15, 18, ..., 48]
  
  let result2 =
    data.filter() { $0 > 10  &&  $0 < 50  &&  $0 % 3 == 0 }
  result2
}

// map und flatMap
if true {
  let data = [2, 5, 4]
  func f(_ n: Int) -> String {
    var result = ""
    for _ in 1...n { result += "*" }
    return result
  }
  data.map(f)  // ["**", "*****", "****"]
  
  let txt =
    "Lorem ipsum dolor sit amet, consetetur sadipscing elitr."
  let ar1 = txt.components(separatedBy: " ")
  let ar2 = ar1.map() { $0.characters.count }
  
  let ar3 = txt.components(separatedBy: " ")
    .map() { $0.characters.count }

  
  var ar = [1, 2, 3]
  let nested = ar.map( { Array(1...$0) } )
  // nested = [[1], [1, 2], [1, 2, 3]]
  let flat = ar.flatMap( { Array(1...$0) } )
  // flat = [1, 1, 2, 1, 2, 3]
}

// Array durchlaufen, read-only
if true {
  let ar = Array(1...10)
  for item in ar {
    print(item)
  }
  
  // weitgehend gleichwertig
  ar.forEach() { (i) in
    print(i)
  }
  
  let data = [2.7, 3.9, 1.6]
  var sum = 0.0
  data.forEach( { sum += $0} )
  print(sum)  // Ausgabe: 8,2
  
  let s = "abc"
  s.characters.forEach( { print($0) } )
  // Ausgabe: "a", "b", "c"
  
  (65...68).forEach()
    { print(UnicodeScalar($0) as Any, terminator: "") }
  print("")
  // Ausgabe "ABCD"
  
  let nmbs = Array(1...20)
  nmbs.filter( {$0 % 3 == 0} )
    .map( {$0*$0} )
    .forEach( {print($0)} )
  // Ausgabe: 9, 36, 81, 144, 225, 324

}

// Array-Elemente ändern
if true {
  var ar = Array(1...10)
  for i in ar.indices {
    ar[i] += 1
  }
}

// enumerate
if true {
  var ar = [7, 3, 5]
  for (n, value) in ar.enumerated() {
    print("Index \(n) -- Wert \(value)")
    ar[n] += 1
  }
  print(ar)
}

// reduce
if true {
  let ar = [1, 7, 12, 5]
  let sum = ar.reduce(0) {$0+$1}   // 25
  sum
  
  let data = [0xff, 0xf0, 0x10]
  let result = data.reduce(0xffff)  { $0 & $1 }
  String(result, radix:16)  // Ergebnis hexadezimal "10"
  
}

// split und joined
if true {
  let data = [1, 2, 0, 5, 6, 4, 0, 3, 0, 2]
  let splitted = data.split {$0==0}
  // Datentyp [ArraySlice<Int>]
  splitted  // [[1, 2], [5, 6, 4], [3], [2]]
  
  let joined = splitted.joined(separator: [0])
  // Datentyp JoinSequence<Array<ArraySlice<Int>>>

  let newdata = Array(joined) as [Int] // [1, 2, 0, 5, 6, 4, 0, 0, 3, 0, 2]
  newdata == data  // true
  
  let s = ["e4", "e5", "c7", "c6"].joined(separator: ";")
}

// shuffle
if true {
  var ar = Array(1...10)
  for i in 0..<ar.count {
    let n = Int(arc4random_uniform(UInt32(ar.count-1)))
    if n != i {
      swap(&ar[i], &ar[n])
    }
  }
  print(ar)    // Ausgabe z. B. [3, 10, 5, 1, 9, 4, 6, 8, 2, 7]
}

// Doppelgänger entfernen (Code umformuliert)
if true {
  var ar = [1, 7, 3, 1, 5, 2, 3, 3,  3]
  for i in 0 ..< ar.count-1 {
    var j = ar.count - 1
    while(j > i) {
      if ar[i] == ar[j] {
        ar.remove(at: j)
      }
      j -= 1
    }
  }
  print(ar)
  
  // Alternative:
  ar = Array(Set(ar))
}

