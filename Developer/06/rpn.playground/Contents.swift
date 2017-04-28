import UIKit

// RPN-Rechner mit globalen Funktionen

// Ziel 17,3 / (12,5 - 7,6 * 2,1) ausrechnen
var stack = [17.3, 12.5, 7.6, 2.1]

// zwei Werte vom Stack entfernen,
// durch die Funktion fn verknüpfen
// Ergebnis wieder auf dem Stack speichern
func calculate(_ fn: (Double, Double) -> Double) {
  if stack.count >= 2 {
    let op1 = stack.removeLast()
    let op2 = stack.removeLast()
    let result = fn(op2, op1)
    print(result)
    stack.append(result)
  }
}

calculate( * )         // Ausgabe 15,96
// calculate( - )      // fn. in Swift 2.2 nicht mehr
calculate( {$0-$1} )   // Ausgabe -3,46
calculate( / )         // Ausgabe -5,00
print(stack)           // stack enthält nur noch [-5,00]

// einen Wert vom Stack entfernen, darauf die Funktion fn
// anwenden, Ergebnis wieder auf dem Stack speichern
func calculate(_ fn: (Double) -> Double) {
  if stack.count >= 1 {
    stack.append( fn(stack.removeLast()) )
  }
}

stack = [4.0]
calculate( sqrt )
print(stack)          // Stack enthält jetzt [2,0]
calculate( sin )
print(stack)          // [0,91]
// calculate( - )     // Fehler
calculate( {-$0} )
print(stack)          // [-0,91]

// RPN-Rechner als Klasse formuliert
class RPN {
  var stack = [Double]()
  
  func test() {
    // Ziel 17,3 / (12,5 - 7,6 * 2,1) ausrechnen
    stack = [17.3, 12.5, 7.6, 2.1]
    
    calculate( * )         // Ausgabe 15,96
    // calculate( - )      // fn. in Swift 2.2 nicht mehr
    calculate( {$0-$1} )   // Ausgabe -3,46
    calculate( / )         // Ausgabe -5,00
    print(stack)           // stack enthält nur noch [-5,00]
    
    
    stack = [4.0]
    calculate( sqrt )
    print(stack)          // Stack enthält jetzt [2,0]
    calculate( sin )
    print(stack)          // [0,91]
    // calculate( - )     // Fehler
    calculate( {-$0} )
    print(stack)          // [-0,91]
    
  }
  
  
  // zwei Werte vom Stack entfernen,
  // durch die Funktion fn verknüpfen
  // Ergebnis wieder auf dem Stack speichern
  func calculate(_ fn:(Double, Double)->Double) {
    if stack.count >= 2 {
      let op1 = stack.removeLast()
      let op2 = stack.removeLast()
      let result = fn(op2, op1)
      print(result)
      stack.append(result)
    }
  }
  
  // einen Wert vom Stack entfernen, darauf die Funktion fn
  // anwenden, Ergebnis wieder auf dem Stack speichern
  func calculate(_ fn: (Double) -> Double) {
    if stack.count >= 1 {
      stack.append( fn(stack.removeLast()) )
    }
  }
}

let rpn = RPN()
rpn.test()

