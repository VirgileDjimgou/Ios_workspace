//: Playground - noun: a place where people can play

import Cocoa
// Geometry-Protokoll
protocol Geometry {
  func getArea() -> Double
  func getPerimeter() -> Double
}

// Rechteck-Struktur
struct Rectangle : Geometry {
  var length:Double, width:Double
  init(_ l:Double, _ w:Double) {
    length=l
    width=w
  }
  func getArea() -> Double {
    return length * width
  }
  func getPerimeter() -> Double {
    return 2 * (length + width)
  }
}

// Kreis-Struktur
struct Circle : Geometry {
  var radius:Double
  init(_ r:Double) {
    radius = r
  }
  func getArea() -> Double {
    return radius * radius * M_PI
  }
  func getPerimeter() -> Double {
    return 2 * radius * M_PI
  }
}

// Beispieldateien zusammenstellen
var geos = [Geometry]()
geos.append(Circle(3.5))
geos.append(Rectangle(4.8, 3.6))
geos.append(Circle(2.2))

// nach Flächeninhalt sortieren und ausgeben
geos.sortInPlace( {$0.getArea() < $1.getArea() } )
for g in geos {
  print(g.getArea())
}

