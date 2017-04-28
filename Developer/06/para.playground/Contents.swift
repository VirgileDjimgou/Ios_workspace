//: Playground - noun: a place where people can play

import UIKit


// Wert- versus Referenzparameter
if true {
  func f(n: Int) {
    // n = 3   // Fehler, n ist nicht veränderlich!
  }
  
  // eine ganz simple Klasse
  class MyClass {
    var a = 1, b = 2
  }
  
  // Funktion zur Verarbeitung von MyClass-Objekten
  func f(para: MyClass) {
    para.a = 4
  }
  // Test
  var mc = MyClass()  // mc.a ist 1
  f(para: mc)         // MyClass ist ein Referenztyp
  print(mc.a)         // mc.a ist jetzt 4
}

// unbenannte Parameter (namenlose Parameter)
if true {
  func sum(_ a: Int, _ b: Int, _ c: Int, _ d: Int) -> Int {
    return a + b + c + d
  }
  let result = sum(1, 7, 12, -2)   // Ergebnis: 18
}

// zweinamige Parameter
if true {
  func f(start x1: Double, end x2: Double,
         count n: Int) -> [Double]?
  {
    if n <= 1 { return nil }  // unsinnig, Fehler
    var result = [Double]()
    result.reserveCapacity(n)
    let delta = (x2 - x1) / Double(n - 1)
    for i in 0..<n {
      result += [ x1 + delta * Double(i) ]
    }
    return result
  }
  
  let ar = f(start: 100.0, end: 200.0, count: 5)!
  print(ar)         // [100.0, 125.0, 150.0, 175.0, 200.0]
  // f(100.0, 200.0, 5)  // Fehler, Parameternamen fehlen

}


// inout-Parameter, Beispiel 1
if true {
  // Funktion, die den Parameter n verändert
  func f(n: inout Int) {
    n += 1
  }
  
  var x=3
  f(n: &x)      // übergibt die Variable x (nicht deren Wert) an f()
  print(x)   // 4
  // f(n: x)       // Fehler, & fehlt
  // f(n: 3)       // Fehler, es muss eine Variable übergeben werden

}

// inout-Parameter, Beispiel 2 (nicht im Buch erwähnt)
if true {
  // eine ganz simple Klasse
  class MyClass {
    var a = 1, b = 2
    
    init(a: Int, b: Int) {
      self.a = a
      self.b = b
    }
  }

  // f weist dem Parameter ein neues Objekt zu
  func f(para: inout MyClass) {
    para = MyClass(a: 2, b: 4)
  }

  var x = MyClass(a: 1, b: 2)
  f(para: &x)
  print("x.a = \(x.a), x.b = \(x.b)")
  // Ausgabe: x.a = 2, x.b = 4
}


// inout-Parameter, Beispiel 3 (Array)
if true {
  // Funktion vergrößert den Wert jedes Array-Elements um eins
  func f(data: inout [Int]) {
    // Vorsicht: so funktioniert es nicht!
    // for var item in data {
    //   item += 1
    // }
    for i in data.indices {
      data[i] += 1
    }
    
  }
  
  var x = [1, 2, 7, 8]
  f(data: &x)
  print(x)  // Ausgabe [2, 3, 8, 9]
}

// Default-Paramter
if true {
  func f(start: Double, end:Double,
         count n: Int = 10) -> [Double]?
  {
    if n<=1 { return nil }  // unsinnig, Fehler
    var result = [Double]()
    result.reserveCapacity(n)
    let delta = (end - start) / Double(n - 1)
    for i in 0..<n {
      result += [ start + delta * Double(i) ]
    }
    return result
  }

  let ar1 = f(start: 0.0, end: 4.0)            // Array mit 10 Elementen
  let ar2 = f(start: 0.0, end: 4.0, count: 5)  // Array mit 5 Elementen
  // let ar3 = f(start: 0.0, end: 4.0, 7)      // Fehler, Parametername fehlt
}

// variable Parameteranzahl
if true {
  func min(of data: Double ...) -> Double? {
    if data.count == 0 { return nil }
    var result = data[0]
    for d in data {
      if d < result { result = d }
    }
    return result
  }
  
  min()                    // nil
  min(of: 4.0, 1.0, 2.0, 3.0)  // 1.0 als Optional

}
