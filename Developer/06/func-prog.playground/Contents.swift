//: Playground - noun: a place where people can play

import UIKit

// Funktionale Programmierung

// Funktionen als eigener Datentyp
if true {
  // die Variable x kann Funktionen aufnehmen,
  // die der folgenden Signatur entsprechen
  var x: (Double, Double) -> (Int, Double)
  
  // f ist eine mögliche Implementierung einer solchen Funktion
  func f(a: Double, b: Double) -> (Int, Double) {
    if a>b { return (1, a * b) }
    else   { return (2, a + b) }
  }
  // nun kann x wie f verwendet werden
  x = f
  x(2.0, 3.0)        // Ergebnis (2, 5.0)
  f(a: 2.0, b: 3.0)  // Ergebnis (2, 5.0)
  
  x = { (7, $0 / $1) }
  x(2.0, 3.0)        // Ergebnis (7, 1.666667)

}

// Funktionen als Parameter und Rückgabeergebnisse
if true {
  func buildArray(n: Int,
                  start: Double,
                  end: Double,
                  fn: (Double) -> Double)
    -> [Double]
  {
    var result = [Double]()
    let delta = (end-start) / Double(n-1)
    for i in 0..<n {
      let x = start + delta * Double(i)
      result += [fn(x)]
    }
    return result
  }
  
  // einfache Funktion, berechnet 1 / (1+x)
  func f(x: Double) -> Double {
    return 1.0 / (1.0 + x)
  }
  
  // zwei Testaufrufe von buildArray
  let data1 = buildArray(n: 20, start: 0, end: 5, fn: f)       // [1.0, 0.79, ...]
  let data2 = buildArray(n: 10, start: 0, end: 3.14, fn: sin)  // [0.0, 0.34, ...]
  
  // zur Visualisierung in Playground
  for d in data1 { d }
  for d in data2 { d }

}

// Funktionen als Rückgabewert
if true {
  // bildet die Funktion a + x*b + x^2*c
  func fbuilder(a: Double, b: Double, c: Double) ->
    ( (Double) -> Double) {
      func f(x: Double) -> Double {
        return a + x * b + x * x * c
      }
      return f
  }
  
  // zwei Beispielfunktionen erzeugen
  let f1 = fbuilder(a: 1.0, b: 2.0, c: -0.5)
  let f2 = fbuilder(a: 2.0, b: 0.0,  c: 0.7)
  
  // Funktionsergebnisse für x-Werte zwischen -3 und 3 ausrechnen
  var x = -3.0
  while(x < 3.0) {
    var y1 = f1(x)
    var y2 = f2(x)
    x+=0.05
  }
}





















