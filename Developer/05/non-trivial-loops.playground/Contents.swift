//: Playground - noun: a place where people can play

import Cocoa

//: ## while statt for

//for(i=99; i>0; i -= 2) {
//  print(i)
//}

var i = 99
while(i>0) {
  print(i)
  i -= 2
}


//: ## for-in statt for
// Swift-2-Code
let start=3, end=6
// for i = start; i < end; i++ {  print(i) }

// Swift-3-Code
for i in start..<end { print(i) }

//: ## Array rückwärts

var data = [7, 243, 23, 34]
// Swift-2-Code
// for i = data.count-1; i>=0; i-- { print(data[i]) }

// Swift-3-Code, wenn Elemente nur ausgelesen werden sollen
for item in data.reversed() {
  print(item)
}

// Werte ändern, Variante 1
i = data.count-1
while(i>=0) {
  data[i] = 0
  i -= 1
}

// Werte ändern, Variante 2 (übersichtlicher und schneller)
for i in data.indices.reversed() {
  data[i] = 0
}

// Werte ändern, Variante 3 (auch schnell, aber unübersichtlich)
let maxidx = data.count - 1
for i in 0...maxidx {
  data[maxidx - i] = 0
}

//: ## Double-Schleifen

let xstart = 17.0, xend=18.0, steps=10
var x = xstart
let delta = (xend - xstart) / Double(steps)

// Vorsicht, es ist nicht sicher, dass der Endwert erreicht wird
while(x <= xend) {
  print( String(format: "%.15f", x) )
  x += delta
}

// bessere Lösung mit Integer-Schleifenvariable
for i in 0...steps {
  let x = xstart + delta * Double(i)
  print( String(format: "%.15f", x) )
}

// alternative while-Lösung mit besserer Bedingung
let epsilon = delta / 1000
x = xstart
while(x <= xend + epsilon) {
  print( String(format: "%.15f", x) )
  x += delta
}

//: ## Double-Schleifen mit stride

// falsche Lösung, erreicht den Endwert nicht immer
for x in stride(from: xstart, to: xend, by: delta) {
  print(x)
}

// korrekte Lösung
for x in stride(from: xstart, to: xend + epsilon, by: delta) {
  print(x)
}

// stride für negative Schleifen
for x in stride(from: xend, to: xstart - epsilon, by: -delta) {
  print(x)
}
