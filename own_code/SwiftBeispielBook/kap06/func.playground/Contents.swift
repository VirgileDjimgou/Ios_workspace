//: Playground - noun: a place where people can play

import UIKit

// Funktionen
func strRepeat(s:String, n:Int) -> String {
  if n<=0 {
    return ""
  } else {
    var result=s       // result mit s initialisieren
    for _ in 1..<n {   // noch (n-1)-mal s hinzufügen
      result+=s
    }
    return result      // Ergebnis zurückgeben
  }
}

strRepeat("abc", n:3)  // "abcabcabc"


func f() -> String {        // String als Ergebnis
  return ""
}

func f() -> [Int] {         // Int-Array als Ergebnis
  return [1, 2, 3]
}

func f(n:Int) -> [Int]? {   // Int-Array oder nil
  if n<=0 {
    return nil
  } else {
    return [Int]()
  }
}

func sincos(x:Double) -> (Double, Double) {
  return (sin(x), cos(x))
}

let (s, c) = sincos(1.23)
print(s)   // 0.942488801931697
print(c)   // 0.334237727124503

func left(s:String, n:Int) -> String! {
  if n<=0 {
    return nil  // unsinnig, nil zurückgeben
  } else if n>=s.characters.count {
    return s    // alles zurückgeben
  } else {
    // die ersten n Zeichen zurückgeben
    let start = s.startIndex
    let end   = start.advancedBy( n)
    return s[start..<end]
  }
}

left("Hello World!", n:5)     // "Hello"
left("Hello World!", n:100)   // "Hello World!"
left("Hello World!", n:-1)    // nil

// globale Funktion f(x, y)
func f(x:Double, _ y:Double) -> Double {
  
  // Hilfsfunktion f1(x, y)
  func helpfunc1(x:Double, _ y:Double) -> Double {
    return sqrt(x*x + y*y)
  }
  // Hilfsfunktion f2(x, y)
  func helpfunc2(x:Double, _ y:Double) -> Double {
    return x*y
  }
  
  // Aufruf der Hilfsfunktionen
  return helpfunc1(x, y) + helpfunc2(x, y)
}

f(3.0, 4.0)  // 17.0

func fak(n:Int) -> Int {
  if n<=0 {
    return 0
  } else if n<=2 {
    return n
  } else {
    // rekursiver Aufruf von n
    return n * fak(n-1)
  }
}

fak(6)   // 720
fak(13)  // 6.227.020.800

