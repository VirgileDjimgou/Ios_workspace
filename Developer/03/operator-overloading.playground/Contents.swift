

import Cocoa

//: ## Operator Overloading für komplexe Zahlen
// Datenstruktur zur Speicherung komplexer Zahlen
struct Complex {
  var re: Double
  var im: Double
  
  // Init-Funktion, um eine neue komplexe Zahl zu erzeugen
  init(re: Double, im: Double) {
    self.re=re
    self.im=im
  }
}

// Addition komplexer Zahlen
func + (left: Complex, right: Complex) -> Complex {
  return Complex(re: left.re + right.re, im: left.im + right.im)
}

// Multiplikation komplexer Zahlen
func * (left: Complex, right: Complex) -> Complex {
  return Complex(re: left.re * right.re - left.im * right.im,
                 im: left.re * right.im + left.im * right.re)
}

// Vergleich komplexer Zahlen
func == (left: Complex, right: Complex) -> Bool {
  return left.re == right.re   &&   left.im == right.im
}
func != (left: Complex, right: Complex) -> Bool {
  return !(left==right)
}

// Operatoren anwenden
var a = Complex(re: 2, im: 1)  //  2 +  i
var b = Complex(re: 1, im: 3)  //  1 + 3i
var c = a + b                  //  3 + 4i
var d = a * b                  // -1 + 7i

// negatives Vorzeichen für komplexe Zahlen
prefix func - (op: Complex) -> Complex {
  return Complex(re: -op.re, im: -op.im)
}
var e = -d
