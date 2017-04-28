//: Playground - noun: a place where people can play

import UIKit

// Arrays sind Werttypen!
if true {
  var ar1 = [1, 2, 3]
  var ar2 = ar1   // ar2 enthält Kopie von ar1
  ar2[1]=0
  ar1             // ar1 ist unverändert [1, 2, 3]
  ar2             // ar2 enthält [1, 0, 3]
  
  func changeArray(_ x: inout [Int]) {
    x[0] = -1
  }
  changeArray(&ar1)
  ar1
}

// Arrays initialisieren
if true {
  var nmbs = [1, 2, 3, 4]
  let strgs = ["abc", "efg", "xyz"]
  let various = [1, "abc", true] as [Any]
  
  nmbs.remove(at: 1)       // nmbs = [1, 3, 4]
  nmbs.append(12)             // nmbs = [1, 3, 4, 12]
  nmbs[0] = -4                // nmbs = [-4, 3, 4, 12]
  // strgs.append("zzz")         // Fehler, strgs ist unveränderlich

  var sar = [String]()        // leeres String-Array
  var dar = Array<Double>()   // leeres Double-Array
  var iar: [Int] = Array()    // leeres Integer-Array

  let s = "abcde"
  var car = Array(s.characters)  // Character-Array mit den
  // Elementen ["a", "b", ...]
  iar = Array(3...7)         // Int-Array mit den Elementen
  // [3, 4, 5, 6, 7]
  
  iar = [Int](repeating: 0, count: 1000)
}

// Array-Elemente auslesen
if true {
  var nmbs = [1, 2, 3, 4]
  nmbs.count     // 4
  nmbs.isEmpty   // false
  nmbs[0]        // 1
  nmbs[3]        // 4
  // nmbs[4]     // Fehler, dieses Array-Element existiert nicht
  
  nmbs.first     // Optional mit Datentyp Int?
  nmbs.first!    // 1 (Dateityp Int)
  nmbs.last!     // 4

  var slc = nmbs[1...3]    // [2, 3, 4]
  
  for n in nmbs {
    print(n)
  }
}

// ArraySlice's
if true {
  var nmbs = Array(1...10)   // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  var slc = nmbs[3...7]      // [4, 5, 6, 7, 8]
  slc.count                  // 5
  slc[3]                     // 4
  slc[5] = -5
  slc                        // [4, 5, -5, 7, 8]
  nmbs                       // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  for n in slc {
    print(n)
  }
}

// Arrays manipulieren
if true {
  var ar = Array(5...7)    // [5, 6, 7]
  ar.append(8)             // [5, 6, 7, 8]
  ar.insert(0, at: 3)      // [5, 6, 7, 0, 8]
  ar += [17]               // [5, 6, 7, 0, 8, 17]
  ar += [18, 19, 20]       // [5, 6, 7, 0, 8, 18, 19, 20]
  
  var a1 = [1, 2, 3, 4]
  var a2 = [7, 8, 9]
  a1.insert(contentsOf: a2, at: 2)
  a1   // enthält jetzt [1, 2, 7, 8, 9, 3, 4]
}

if true {
  var ar = Array(5...12)   // ar = [5, 6, 7, 8, 9, 10, 11, 12]
  ar.removeLast()          // ar = [5, 6, 7, 8, 9, 10, 11]
  ar
  ar.remove(at: 3)         // ar = [5, 6, 7, 9, 10, 11]
  ar
  ar.removeSubrange(0...2) // ar = [9, 10, 11]
  ar
  ar[1...2] = []           // ar = [9]
  ar
  ar.removeAll()           // ar = []
  
  ar = Array(5...12)       // ar = [5, 6, 7, 8, 9, 10, 11, 12]
  ar.removeFirst(3)        // ar = [8, 9, 10, 11, 12]
}

// replaceSubrange
if true {
  var ar = Array(5...12)   // ar = [5, 6, 7, 8, 9, 10, 11, 12]
  ar[3] = -1               // ar = [5, 6, 7, -1, 9, 10, 11, 12]
  ar
  ar.replaceSubrange(1...3, with: [-3, -4, -5])
  ar                       // ar = [5, -3, -4, -5, 9, 10, 11, 12]
  ar[3...6] = [-6, -5, -5, -6]
  ar                       // ar = [5, -3, -4, -6, -5, -5, -6, 12]
}

// Arrays verbinden
if true {
  let ar1 = [1, 2, 3]
  let ar2 = [4, 5, 6, 7]
  let ar3 = ar1 + ar2  // ar3 = [1, 2, 3, 4, 5, 6, 7]
}

// sort und reverse
if true {
  var ar = [17, 12, 4, 19, 3]
  ar.sort(by: { (i1, i2) -> Bool in i1 < i2 } )
  ar.sort(by: {$0<$1} )  // Kurzschreibweise
  ar.sort() {$0<$1}      // Closure nachgestellt
  ar.sort(by: <)         // noch kürzer
  ar.sort()               // Default-Sortierordnung aufsteigend
  
  let ascending = ar.sorted(by: >)

  ar = [7, 1, 9, 2]
  let rev = ar.reversed()
  for item in ar.reversed() {
    print(item)
  }

  for item in ar.reversed().lazy {
    print(item)
    if item > 3 { break }
  }
}


// mehrdimensionale Arrays
if true {
  var ar = [[1, 2, 3], [4, 5, 6]]
  ar.count
  for zeile in 0..<ar.count {
    for spalte in 0..<ar[zeile].count {
      print("\(ar[zeile][spalte]), ", terminator: "")
    }
    print()  // neue Zeile
  }
  // Ausgabe: 1, 2, 3,
  //          4, 5, 6,

  var ar2d = [[Int]]()       // zweidimensionales Int-Array
  var ar3d = [[[Double]]]()  // dreidimensionales Double-Array
  ar2d = [[Int]](repeating: [Int](repeating: 0,
                                  count: 100),
                 count: 20)

}

func createArray2D<T>(_ n: Int, by m: Int, value:T)  -> [[T]] {
  return [[T]](
    repeating: [T](repeating: value, count: m),
    count: n)
}

// Anwendung
var ar1 = createArray2D(20, by: 100, value: 0)   // Int-Array
var ar2 = createArray2D(5, by: 5, value: "bla")  // String-Array

