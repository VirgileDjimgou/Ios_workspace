//: Playground - noun: a place where people can play

import UIKit

func strRepeat(s: String, n: Int) -> String {
  if n <= 0 {
    return ""
  } else {
    var result=s          // result mit s initialisieren
    for _ in 1..<n {      // noch (n-1)-mal s hinzufügen
      result += s
    }
    return result         // Ergebnis zurückgeben
  }
}

strRepeat(s: "abc", n: 3)  // "abcabcabc"

// Parameter: benannt oder nicht
if true {
  // Funktion mit benannten Parameter
  let locDe = Locale(identifier: "de_DE")
  // let locFr = Locale("fr_FR")  // Fehler: Hier müssen
  // Parameternamen verwendet werden
  let rect = CGRect(x: 1, y: 1, width: 2, height: 2)
  
  
  // Funktionen ohne benannte Parameter
  print("abc")
  let i = Int("123")
  let minimum = min(1, 2, 3)
  
  // Methoden mit einem unbenannten und weiteren benannten Paramtern
  let s = "abc"
  if s.compare("Abc", options: .caseInsensitive, range: nil, locale: nil) == .orderedSame
  {
    print("gleichwertig")
  }
}

// Tupel zurückgeben
if true {
  func sincos(_ x: Double) -> (Double, Double) {
    return (sin(x), cos(x))
  }
  
  let (s, c) = sincos(1.23)
  print(s)   // 0.942488801931697
  print(c)   // 0.334237727124503

}

// Optionals zurückgeben
if true {
// gibt die ersten n Zeichen von s zurück
  func left(_ s: String, n: Int) -> String! {
    if n <= 0 {
      return nil  // unsinnig, nil zurückgeben
    } else if n >= s.characters.count {
      return s    // alles zurückgeben
    } else {
      // die ersten n Zeichen zurückgeben
      let start = s.startIndex
      let end   = s.index(start, offsetBy: n)
      return s[start..<end]
    }
  }
  
  left("Hello World!", n: 5)     // "Hello"
  left("Hello World!", n: 100)   // "Hello World!"
  left("Hello World!", n: -1)    // nil
}


// Gültigkeitsebenen, Teil 1
if true {
  var x = 2             // globale Variable
  
  func f(_ n: Int) -> Int {
    x = x + 1           // jeder Aufruf von f()
    return 2*n          // verändert x!
  }
  
  let ergebnis1 = f(7)   // 14
  let ergebnis2 = f(9)   // 19
  print(x)               // x ist jetzt 4

}


// Gültigkeitsebenen, Teil 2
if true {
  func f(_ n: Int) -> Int {
    let result = n*2    // lokale Variable, gilt nur in f()
    return result
  }
  
  let ergebnis1 = f(4)
  // print(result)         // Fehler: 'result' ist nicht definiert

}


// verschachtelte Funktionen
if true {
  func f(x: Double, y: Double) -> Double {
    
    // Hilfsfunktion f1()
    func helpfunc1(a: Double, b: Double) -> Double {
      return sqrt(a * a + b * b)
    }
    // Hilfsfunktion f2()
    func helpfunc2(e: Double, f: Double) -> Double {
      return e * f
    }
    
    // Aufruf der Hilfsfunktionen
    return helpfunc1(a: y, b: y) + helpfunc2(e: x, f: y)
  }
  
  f(x: 3.0, y: 4.0)  // 17.0
}


// Rekursion (Fakultät)
if true {
  // rekursive Implementierung der Fakultätsfunktion
  func f(_ n: Int) -> Int {
    if n<=0 {
      return 0
    } else if n<=2 {
      return n
    } else {
      // rekursiver Aufruf von n
      return n * f(n-1)
    }
  }
  
  f(6)   // 720
  f(13)  // 6.227.020.800
}


