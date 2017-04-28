//
//  main.swift
//  cgfloat-cgpoint
//
//  Created by Michael Kofler on 12.09.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import Foundation

let x = 3.3              // Double
let y: CGFloat = 4.5     // CGFloat
// let z = x * y         // Fehler!
let z1 = CGFloat(x) * y  // OK, Ergebnistyp CGFLoat
let z2 = x * Double(y)   // auch OK, Ergebnis Double
let z3 = y * .pi

let rect1 = CGRect(x: 1, y: 1, width: 4, height: 3)
let rect2 = CGRect(x: 1.0, y: 1.0, width: 4.0, height: 3.0)
if rect1 == rect2 {
  print("Beide CGRect-Objekte stimmen überein.")
}

let pt = CGPoint(x: 1, y: 1)
let sz = CGSize(width: 4, height: 3)
let rect3 = CGRect(origin: pt, size: sz)
if rect1 == rect3 {
  print("Auch diese beiden CGRect-Objekte sind gleich.")
}

let pt0 = CGPoint.zero
let vec0 = CGVector.zero

let pt1 = CGPoint(x: 1, y: 2)
let pt2 = CGPoint(x: 4, y: 5)

if pt1.equalTo(pt2) {
  print("Die Punkte pt1 und pt2 stimmen überein.")
}

if rect3.contains(pt1)  {
  print("Punkt pt1 befindet sich im Rechteck rect1.")
}

if rect1.intersects(rect2) {
  print("Die Rechtecke rect1 und rect2 überschneiden sich.")
}

print("Minimale X-Koordinate von rect1: \(rect1.minX)")
print("Mittlere Y-Koordinate von rect1: \(rect1.midY)")


// Vektor zu Punkt addieren
let v1 = CGVector(dx: 3, dy: 5)
// pt3 = pt1 + v1
let pt3 = CGPoint(x: pt1.x + v1.dx, y: pt1.y + v1.dy)



// Die folgenden Beispiele setzen die Definitionen
// aus CGOperators.swift voraus!

// Rechnen mit CGPoint und CGVector
let pt4 = pt1 + v1          // Punkt plus Vektor -> Punkt
let v2 = v1 * 0.3           // Vektor mal Skalar -> Vektor

// eigene CGRect-Erweiterungen
let midPt = rect1.middlePoint()  // Mittelpunkt eines Rechtecks

// eigene CGPoint-Erweiterungen
let distance = pt1.distance(to: pt2)  // Datentyp CGFloat
let l = pt1.length()
// stellt sicher, dass pt5 innerhalb von rect1 ist
let pt5 = pt1.setWithin(rect: rect1)

pt5.print("Punkt 5: ")  // Ausgabe: Punkt 5: x=1.00 y=2.00
