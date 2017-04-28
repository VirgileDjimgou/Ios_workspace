//: Playground - noun: a place where people can play

import Cocoa

// for-in-Schleife
if true {
  // Schleife über einen Bereich
  for i in 1...3 {             // i: Int
    print(i)
  }
  // Ausgabe: 1, 2, 3
  
  // Schleife über ein Array
  for i in [1, 4, 7] {        // i: Int
    print(i)
  }
  // Ausgabe 1, 4, 7
  
  // Schleife über die Zeichen einer Zeichenkette
  let s = "abc"
  for c in s.characters {     // c: Character
    print(c)
  }
  // Ausgabe: "a", "b", "c"
  
  // Schleife über Dictionary
  let dict = ["one":  "eins", "two": "zwei"]
  for (engl, germ) in dict {   // engl:String, germ:String
    print("\(engl) -- \(germ)")
  }
  // Ausgabe: one -- eins
  //          two -- zwei

  // Schleife ohne Schleifenvariable
  for _ in 1...10 {
    print(arc4random_uniform(100))
  }

  for i in (1...3).reversed() {
    print(i)
  }
}

// while-Schleife
if true {
  var n=1
  while n<=10 {
    print(n)
    n += 1
  }
  // Ausgabe: 1, 2, ..., 10

  var ar = [28, 34, 12]
  var gen = ar.makeIterator()    // Generator für das Array
  while let i = gen.next() {     // i hat den Datentyp Int
    print(i)
  }
}


// repeat-while-Schleife
if true {
  var n=1
  repeat {
    print(n)
    n += 1
  } while n<=10
  // Ausgabe: 1, 2, ..., 10
}


// break
if true {
  for i in 1...10 {
    print(i)
    if i == 5 { break }
  }
  // Ausgabe: 1, 2, ..., 5
  
  
  iloop:             // Label für die nachfolgende Schleife
    for i in 1...10 {
      for j in 1...10 {
        print("i=\(i), j=\(j)")
        if i+j > 15 {
          break iloop  // die i-Schleife verlassen
        }
      }
  }
  // Ausgabe:
  // i=1, j=1
  // i=1, j=2
  // ...
  // i=6, j=10

}

// continue
if true {
  for i in 1...20 {
    if i % 2 == 0 { continue }
    print(i)
    if i > 8 { break }
  } // Ausgabe: 1, 3, 5, 7, 9
}


// implizite Schleifen
if true {
  let data = [4, 74, 345, 13]
  var sum = 0
  // forEach bildet die Summe
  data.forEach() {sum += $0}
  print(sum)      // Ausgabe 436
  
  // map erzeugt ein neues Array
  let newData = data.map() { $0 + 7 }
  print(newData)  // Ausgabe [11, 81, 352, 20]
}
