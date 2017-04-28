
import Foundation

// bildet die Funktion a + x*b + x^2*c
func fbuilder(a:Double, b:Double, c:Double) ->
  ( Double -> Double) {
    func f(x:Double) -> Double {
      return a + x*b + x*x*c
    }
    return f
}

// zwei Beispielfunktionen erzeugen
let f1 = fbuilder(1.0, b: 2.0, c: -0.5)
let f2 = fbuilder(2.0, b: 0.0,  c: 0.7)

// Funktionsergebnisse für x-Werte zwischen -3 und 3 ausrechnen
var x = -3.0
while(x<3.0) {
  var y1 = f1(x)
  var y2 = f2(x)
  x+=0.05
}
