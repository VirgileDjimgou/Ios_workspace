//: Playground - noun: a place where people can play

import Cocoa

//: Tupel vergleichen (zulässig für Tupel mit bis zu sechs Elementen)
let tupel1 = (1, 2)
let tupel2 = (1, 2)
if tupel1 == tupel2 {
  print("Die beiden Tupel sind identisch.")
}

// das folgende Beispiel funktioniert nicht, weil tupel3 zu viele Elemente hat
//let tupel3 = (1, 2, 3, 4, 5, 6, 7)
//let tupel4 = (1, 2, 3, 4, 5, 6, 7)
//if tupel3 == tupel4 {
//  print("Die beiden Tupel sind identisch.")
//}


//: Schlüsselwörter von Swift (hier `in`) als Parameter verwenden
func f(in in:Int, inout out:Int) {
  out = `in` * 2
}
var x:Int = 0
f(in:2, out: &x)
print(x)

//: Unterschiedliche Code-Zweige je nach Swift-Version
#if swift(>=3)
  print("Ein Blick in die Zukunft")
#else
  print("Noch mit Swift 2.n unterwegs")
#endif

//: Neue Syntax zum Zugriff auf den aktuellen Dateiname, die Zeilennummer etc.
let fname = #file
let linenr = #line

//: removeFirst() für Arrays
var ar = [1, 2, 3, 4]
ar.removeFirst()
print(ar)

//: Tuple Splat ist deprecated
func g(a a:Int, b:Int, c:Int) -> Int {
  return a+b+c
}
let tupel = (a:2, b:4, c:8)
print( g(tupel) )  // diese Form des Funktionsaufrufs ist jetzt deprecated

//: var-Parameter sind deprecated
func h(var a:Int) {
  a+=1
  print(a)
}
h(3)

