//: Playground - noun: a place where people can play

import Foundation

// print
print(1, 2, 3)
print("Hello", "World!")

print(1, 2, 3, separator:"")
print("Hello ", terminator:"") // hier kein Zeilenumbruch!
print("World!")                // Ausgabe: Hello World!
// das Zusammenfügen mehrere print-Ausgaben in eine Zeile
// kann nur in kompilierten Programmen beobachtet werden
// und funktioniert im Playground nicht

// min/max
if true {
  min(1, 2, 3)  // 1
  max(1, 2, 3)  // 3
  Array(1...10).minElement()  // 1
  "Hello World".characters.maxElement()  // "r"
}

// swap
if true {
  var a=1, b=2
  swap(&a, &b)
  a     // 2
  b     // 1

  // swap(&a, &a)
}


// zip
if true {
  let time =  ["12:15", "12:30", "12:45", "13:00"]
  let temp = [20.9, 20.8, 20.7, 20.9]
  let combined = zip(time, temp)
  for (tm, tmp) in combined {
    print("Zeit \(tm)  -- Temperatur \(tmp)")
  }
}


// min/max
if true {
  min(1, 2, 3)  // 1
  max(1, 2, 3)  // 3
  Array(1...10).minElement()  // 1
  "Hello World".characters.maxElement()  // "r"
  
  var a=1, b=2
  swap(&a, &b)
  a     // 2
  b     // 1
}

// mathematische Funktionen
if true {
  sqrt(2.0)         // 1,4142135623731
  cos(0.0)          // 1,0
  pow(10.0, 3.0)    // 1000
  M_PI              // 3,14159265358979
  M_E               // 2.71828182845905
}
