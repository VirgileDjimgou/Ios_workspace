//: Playground - noun: a place where people can play

import Foundation

// erzeugt ein Double-Array mit Funktionsergebnissen
// Parameter: n ... gewünschte Anzahl der Array-Elemente
//        start ... Startwert
//          end ... Endwert
//           fn ... Funktion, deren Resultate gespeichert werden
func buildArray(n:Int,
            start:Double,
              end:Double,
               fn:Double->Double) -> [Double]
{
    var result = [Double]()
    let delta = (end-start) / Double(n-1)
    for i in 0..<n {
      let x = start + delta * Double(i)
      result += [fn(x)]
    }
    return result
}

// einfache Funktion, berechnet 1/(1+x)
func f(x:Double) -> Double {
  return 1.0 / (1.0+x)
}

// zwei Testaufrufe von buildArray
let data1 = buildArray(20, start: 0, end: 5, fn: f)       // [1.0, 0.79, ...]
let data2 = buildArray(10, start: 0, end: 3.14, fn: sin)  // [0.0, 0.34, ...]

// zur Visualisierung in Playground
for d in data1 { d }
for d in data2 { d }

