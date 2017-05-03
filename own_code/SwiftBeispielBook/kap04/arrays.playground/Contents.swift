

import UIKit

// jeder if-true-Block hat eigene Variablen; andernfalls
// käme es zu Namenskonflikten

if true {
  var nmbs = [1, 2, 3, 4]
  let strgs = ["abc", "efg", "xyz"]
  
  nmbs.removeAtIndex(1)       // nmbs = [1, 3, 4]
  nmbs.append(12)             // nmbs = [1, 3, 4, 12]
  nmbs[0] = -4                // nmbs = [-4, 3, 4, 12]
  // strgs.append("zzz")      // Fehler, strgs ist unveränderlich
  
  var sar = [String]()        // leeres String-Array
  var dar = Array<Double>()   // leeres Double-Array
  var iar:[Int] = Array()     // leeres Integer-Array
  
  let s="abcde"
  var car = Array(s.characters)  // Character-Array mit den
  // Elementen ["a", "b", ...]
  iar = Array(3...7)           // Int-Array mit den Elemente
  // [3, 4, 5, 6, 7]
  
  // Elemente auslesen
  nmbs = [1, 2, 3, 4]
  nmbs.count     // 4
  nmbs.isEmpty   // false
  nmbs[0]        // 1
  nmbs[3]        // 4
  // nmbs[4]     // Fehler, dieses Array-Element existiert nicht
  
  nmbs.first     // Optional mit Datentyp Int?
  nmbs.first!    // 1
  nmbs.last!     // 4
  
  var sub = nmbs[1...3]    // [2, 3, 4]
}

// ArraySlice
if true {
  var nmbs = Array(1...10)   // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  var sub = nmbs[3...7]      // [4, 5, 6, 7, 8]
  sub.count                  // 5
  sub[3]                     // 4
  sub[5] = -5
  sub                        // [4, 5, -5, 7, 8]
  nmbs                       // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  let someNmbs = Array(sub)
}

// insert und remove
if true {
  var a1 = [1, 2, 3, 4]
  var a2 = [7, 8, 9]
  a1.insertContentsOf(a2, at: 2)
  a1   // enthält jetzt [1, 2, 7, 8, 9, 3, 4]
  
  var ar = Array(5...12)   // ar = [5, 6, 7, 8, 9, 10, 11, 12]
  ar.removeLast()          // ar = [5, 6, 7, 8, 9, 10, 11]
  ar
  ar.removeAtIndex(3)      // ar = [5, 6, 7, 9, 10, 11]
  ar
  ar.removeRange(0...2)    // ar = [9, 10, 11]
  ar
  ar[1...2] = []           // ar = [9]
  ar
  ar.removeAll()           // ar = []
}

// replace range
if true {
  var ar = Array(5...12)   // ar = [5, 6, 7, 8, 9, 10, 11, 12]
  ar[3] = -1               // ar = [5, 6, 7, -1, 9, 10, 11, 12]
  ar
  ar.replaceRange(1...3, with: [-3, -4, -5])
  ar                       // ar = [5, -3, -4, -5, 9, 10, 11, 12]
  ar[3...6] = [-6, -5, -5, -6]
  ar                       // ar = [5, -3, -4, -6, -5, -5, -6, 12]
}

// sort und reverse
if true {
  var ar = [17, 12, 4, 19, 3]
  ar.sortInPlace( { (i1, i2)->Bool in i1<i2 } )
  ar.sortInPlace( {$0<$1} )  // Kurzschreibweise
  ar.sortInPlace(<)          // noch kürzer
  
  ar = [7, 1, 9, 2]
  for item in ar.reverse() {
    print(item)
  }
}

// for, forEach und enumerate
if true {
  var ar = [7, 3, 5]
  var sum=0
  for var i in ar {
    sum += i  // Summe aller Array-Elemente berechnen
  }
  print(sum)
  
  for i in 0 ..< ar.count {
    ar[i] += 1  // jedes Array-Element um eins vergrößern
  }
 
  // alternativer Weg, um jedes Array-Element um eins vergrößern
  ar = ar.map({$0 + 1})
  
  ar.forEach( { print($0) } )  
  
  ar = [7, 3, 5]
  for (n, value) in ar.enumerate() {
    print("Index \(n) -- Wert \(value)")
  }
}

// filter, map und reduce
if true {
  let txt =
  "Lorem ipsum dolor sit amet, consetetur sadipscing elitr."
  let ar1 = txt.componentsSeparatedByString(" ")
  let ar2 = ar1.filter( {$0.characters.count > 5} )
  ar2   // ["consetetur", "sadipscing", "elitr."]
  
  let ar3 = ar1.map( { $0.characters.count } )
  print(ar3)    // [5, 5, 5, 3, 5, 10, 10, 6]

  let ar = [1, 7, 12, 5]
  let sum = ar.reduce(0, combine: {$0+$1} )  // 25
  sum
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
    var j = ar.count-1
    while(j>i) {
      if ar[i] == ar[j] {
        ar.removeAtIndex(j)
      }
      j-=1
    }
  }
  print(ar)
  
  // Alternative:
  ar = Array(Set(ar))
}

// mehrdimensionale Arrays
if true {
  var ar = [[1, 2, 3], [4, 5, 6]]
  ar.count
  for zeile in 0..<ar.count {
    for spalte in 0..<ar[zeile].count {
      print("\(ar[zeile][spalte]), ", terminator: "")
    }
    print("")  // neue Zeile
  }
  // Ausgabe: 1, 2, 3,
  //          4, 5, 6,

  var ar2d = [[Int]]()       // zweidimensionales Int-Array
  var ar3d = [[[Double]]]()  // dreidimensionales Double-Array
  ar2d = [[Int]](count:20,
    repeatedValue:[Int](count:100,
      repeatedValue:0))

}
