//: Playground - noun: a place where people can play

import UIKit


// Closures

// Einführungsbeispiele
if true {
  let data = Array(1...20)        // Datentyp [Int]
  func calc(n: Int) -> Double {
    return sin(Double(n) / 10.0)
  }
  
  // map-Methode mit richtiger Funktion aufrufen
  var result = data.map(calc)     // Datentyp [Double]
  result                          // 0,0998, 0,1987 ...
  
  // map-Methode mit Closure aufrufen
  result =
    data.map( { (n: Int) -> Double in return sin(Double(n)/10) } )

  // verkürzte Syntax ohne return
  result = data.map( { (n: Int) -> Double in sin(Double(n)/10) })
  
  // noch kompaktere Syntax
  result = data.map({ (n) -> Double in sin(Double(n)/10) } )
  
  // auf das Minimum reduzierte Syntax
  result = data.map({ sin(Double($0)/10) } )
  
  // nachgestelle Closures (Trailing Closure)
  result = data.map() { sin(Double($0)/10) }
}

// noch mehr Beispiele
if true {
  let data2 = [1.2, 4.5, 2.4]
  
  // Funktion als Closure
  data2.map(sin)              // [0,93, -0,97, 0,68]
  
  // Operator 'negatives Vorzeichen' als Closure
  data2.map(-)                 // [-1,2, -4,5, -2,4]
  
  data2.sorted(by: <)
}

// mehrzeilige Closures
if true {
  let data = Array(1...20)        // Datentyp [Int]
  let result1 = data.map(
    { (n) -> Double in
      let x = Double(n) / 10.0
      return sin(x)
    }
  )
  
  let result2 = data.map() {
    (n) -> Double in
    let x = Double(n) / 10.0
    return sin(x)
  }
  
  let result3 = data.map({ (_) in 12 } )
}


// Auto-Closures
if true {
  func f(condition: () -> Bool) {
    if condition() {
      print("True!")
    }
  }
  f( condition: {7 % 2 == 1} )  // Ausgabe "True!"
  
  func g(condition: @autoclosure () -> Bool) {
    if condition() {
      print("True!")
    }
  }
  g(condition: 7 % 2 == 1)  // Ausgabe "True!"
}


// Capturing Values
if true {
  func createIncrementor(_ incrAmount: Int = 1) -> () -> Int {
    var total=0
    return {
      total += incrAmount
      return total
    }
  }
  
  let fn1 = createIncrementor() 
  let fn2 = createIncrementor(2)
  let fn3 = createIncrementor(10)
  
  for i in 1...10 {
    print("\(fn1()) \(fn2()) \(fn3()) ")
  }
  // Ausgabe:
  // 1 2 10
  // 2 4 20
  // 3 6 30 
  // ...
  // 10 20 100 

}


