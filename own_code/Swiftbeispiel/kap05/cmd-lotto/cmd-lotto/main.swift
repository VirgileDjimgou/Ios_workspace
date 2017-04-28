//
//  main.swift
//  cmd-lotto
//
//  Created by Michael Kofler on 25.01.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Foundation



// wie lange dauert es, 100 Millionen Zufallszahlen zu erzeugen?
func timeRandom() {
  print("100 Millionen Zufallszahlen")
  let start = NSDate()
  var sum=0
  for _ in 1...100_000_000 {
    sum +=  Int(arc4random_uniform(100))
  }
  let end = NSDate()
  let seconds = end.timeIntervalSinceDate(start)
  print("fertig nach \(seconds) Sekunden")
}

// wie lange dauert es, eine Million Lottozahlen zu erzeugen?
// Startvariante mit Set
func timeWithSet() {
  print("\nSet")
  let start = NSDate()
  for _ in 1...1_000_000 {
    var set = Set<Int>()      // leeres Set erzeugen
    repeat {                  // Ziehung simulieren
      set.insert( Int(arc4random_uniform(49)) + 1 )
    } while(set.count<6)
    // Keys des Dictionary in sortiertes Array umwandeln
    _ = Array(set).sort(<)
  }
  let end = NSDate()
  let seconds = end.timeIntervalSinceDate(start)
  print("fertig nach \(seconds) Sekunden")
}

// wie lange dauert es, eine Million Lottozahlen zu erzeugen?
// Variante 1 ohne Set mit Int-Array; das Int-Array
// wird jedes Mal neu erzeugt
func timeWithIntArray1() {
  print("Int-Array, Variante 1")
  let start = NSDate()
  for _ in 1...1_000_000 {
    var lotto =  [Int](count:6, repeatedValue:0)
    var n=0
    repeat {
      lotto[n] =  Int(arc4random_uniform(49))+1
      // Doppelgängertest
      for i in 0..<n {
        if lotto[i] == lotto[n] {
          n -= 1    // die n-te Lottozahl ist ein Doppel
          break     // gänger, neu erzeugen
        }
      }
      n += 1
    } while(n<6)
    lotto.sortInPlace(<)
  }
  let end = NSDate()
  let seconds = end.timeIntervalSinceDate(start)
  print("fertig nach \(seconds) Sekunden")
}

// wie lange dauert es, eine Million Lottozahlen zu erzeugen?
// Variante 2 ohne Dictionary mit Int-Array
func timeWithIntArray2() {
  print("Int-Array, Variante 2")
  let start = NSDate()
  var lotto =  [Int](count:6, repeatedValue:0)
  for _ in 1...1_000_000 {
    var n=0
    repeat {
      lotto[n] =  Int(arc4random_uniform(49))+1
      // Doppelgängertest
      for i in 0..<n {
        if lotto[i] == lotto[n] {
          n -= 1   // die n-te Lottozahl ist ein Doppel
          break    // gänger, neu erzeugen
        }
      }
      n += 1
    } while(n<6)
    lotto.sortInPlace(<)  // beansprucht ca. 1/2 der Rechenzeit!
  }
  let end = NSDate()
  let seconds = end.timeIntervalSinceDate(start)
  print("fertig nach \(seconds) Sekunden")
}


// wie lange dauert es, eine Million Lottozahlen zu erzeugen?
// Variante ohne Dictionary mit UInt8-Array
func timeWithUInt8Array() {
  print("UInt8-Array")
  let start = NSDate()
  var lotto =  [UInt8](count:6, repeatedValue:0)
  for _ in 1...1_000_000 {
    var n=0
    repeat {
      lotto[n] =  UInt8(arc4random_uniform(49))+1
      // Doppelgängertest
      for i in 0..<n {
        if lotto[i] == lotto[n] {
          n -= 1    // die n-te Lottozahl ist ein Doppel
          break     // gänger, neu erzeugen
        }
      }
      n += 1
    } while(n<6)
    lotto.sortInPlace(<)  // beansprucht ca. 1/2 der Rechenzeit!
  }
  let end = NSDate()
  let seconds = end.timeIntervalSinceDate(start)
  print("fertig nach \(seconds) Sekunden\n")
}

// Lottosimulator, ursprüngliche Variante
func lottoSimulator1() {
  // diese Zahlen müssen geordnet sein!
  let meineZahlen = [1, 6, 12, 14, 25, 33]
  var lotto: [Int]
  var cnt=0
  
  repeat {
    var set = Set<Int>()   // leeres Set erzeugen
    repeat {                   // Ziehung simulieren
      set.insert(Int(arc4random_uniform(49))+1)
    } while(set.count<6)
    // Keys des Dictionary in sortiertes Array umwandeln
    lotto = Array(set).sort(<)
    
    cnt += 1
    if cnt % 100_000 == 0 {
      print("Bisher \(cnt) Ziehungen")
    }
    // Schleife ausführen, bis beide Arrays übereinstimmen
  } while meineZahlen != lotto
  
  print("Sechs richtige Zahlen nach \(cnt) Versuchen")
}

// Lottosimulator, optimierte Variante
func lottoSimulator2() {
  // diese Zahlen müssen geordnet sein!
  let meineZahlen = [1, 6, 12, 14, 25, 33]
  var lotto =  [Int](count:6, repeatedValue:0)
  var cnt=0
  repeat {
    // Lottoziehung simulieren
    var n=0
    repeat {
      lotto[n] =  Int(arc4random_uniform(49))+1
      // Doppelgängertest
      for i in 0..<n {
        if lotto[i] == lotto[n] {
          n -= 1    // die n-te Lottozahl ist ein Doppel
          break     // gänger, neu erzeugen
        }
      }
      n += 1
    } while(n<6)
    lotto.sortInPlace(<)
    
    cnt += 1
    if cnt % 100_000 == 0 {
      print("Bisher \(cnt) Ziehungen")
    }
    
  // Schleife ausführen, bis beide Arrays übereinstimmen
  } while meineZahlen != lotto
  
  print("Sechs Richtige nach \(cnt) Versuchen")
  
}


// ========================================
// hier beginnt die Code-Ausführung


// Benchmarktest
//timeRandom()
//timeWithSet()
//timeWithIntArray1()
//timeWithIntArray2()
//timeWithUInt8Array()

// Variante 1 (langsam)
// lottoSimulator1()

// Variante 2 (schnell)
lottoSimulator2()
