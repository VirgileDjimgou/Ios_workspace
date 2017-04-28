//
//  cg-operators.swift
//  tv-hello-sprite
//
//  Created by Michael Kofler on 10.05.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

// Funktionen und Operatoren, um mit CGFloat, CGPoint 
// und CGRect besser umgehen zu können

// eine umfangreichere Bibliothek finden Sie hier:
// git clone https://github.com/raywenderlich/SKTUtils.git --branch swift
// https://www.raywenderlich.com/80818/operator-overloading-in-swift-tutorial

import SpriteKit



// Pythagoras: a^2 + b^2 = c^2
// c = pythagoras(a, b)
public func pythagoras(_ a:CGFloat, _ b:CGFloat) -> CGFloat {
  return sqrt(a*a + b*b)
}

// y = minMax(x, lower, upper) stellt sicher, dass lower <= y <= upper gilt
public func minMax<T : Comparable>(_ value: T, minimum: T, maximum: T) -> T {
  return max(min(value, maximum), minimum)
}

// Umwandlung mit weniger Tippaufwand
public func cgf(_ value: Double) -> CGFloat {
  return CGFloat(value)
}
public func cgf(_ value: Int) -> CGFloat {
  return CGFloat(value)
}


// Operatoren für CGPoint-Daten
// CGPoints addieren/subtrahieren
public func + (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x + right.x, y: left.y + right.y)
}
public func += (left: inout CGPoint, right: CGPoint) {
  left = left + right
}
public func - (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x - right.x, y: left.y - right.y)
}
public func -= (left: inout CGPoint, right: CGPoint) {
  left = left - right
}



// CGPoint skalieren
public func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x * scalar, y: point.y * scalar)
}
public func *= (point: inout CGPoint, scalar: CGFloat) {
  point = point * scalar
}
public func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x / scalar, y: point.y / scalar)
}
public func /= (point: inout CGPoint, scalar: CGFloat) {
  point = point / scalar
}

// Operatoren für CGVector-Daten
// CGPoints addieren/subtrahieren
public func + (left: CGVector, right: CGVector) -> CGVector {
  return CGVector(dx: left.dx + right.dx, dy: left.dy + right.dy)
}
public func += (left: inout CGVector, right: CGVector) {
  left = left + right
}
public func - (left: CGVector, right: CGVector) -> CGVector {
  return CGVector(dx: left.dx - right.dx, dy: left.dy - right.dy)
}
public func -= (left: inout CGVector, right: CGVector) {
  left = left - right
}

// CGVector skalieren
public func * (vector: CGVector, scalar: CGFloat) -> CGVector {
  return CGVector(dx: vector.dx * scalar, dy: vector.dy * scalar)
}
public func *= (vector: inout CGVector, scalar: CGFloat) {
  vector = vector * scalar
}
public func / (vector: CGVector, scalar: CGFloat) -> CGVector {
  return vector * (1/scalar)
}
public func /= (vector: inout CGVector, scalar: CGFloat) {
  vector = vector / scalar
}




// CGPoint +/- CGVector
public func + (left: CGPoint, right: CGVector) -> CGPoint {
  return CGPoint(x: left.x + right.dx, y: left.y + right.dy)
}
public func - (left: CGPoint, right: CGVector) -> CGPoint {
  return CGPoint(x: left.x - right.dx, y: left.y - right.dy)
}


// CGSize skalieren
public func * (size: CGSize, scalar: CGFloat) -> CGSize {
  return CGSize(width: size.width * scalar, height: size.height * scalar)
}
public func *= (size: inout CGSize, scalar: CGFloat) {
  size = size * scalar
}
public func / (size: CGSize, scalar: CGFloat) -> CGSize {
  return size * (1/scalar)
}
public func /= (size: inout CGSize, scalar: CGFloat) {
  size = size / scalar
}


// CGPoint aus CGRect
public extension CGRect {
  // Mittelpunkt
  func middlePoint() -> CGPoint {
    return CGPoint(x: self.midX, y: self.midY)
  }
  // links unten im iOS-Koordinatensystem
  func minPoint() -> CGPoint {
    return CGPoint(x: self.minX, y: self.minY)
  }
  // rechts oben im iOS-Koordinatensystem
  func maxPoint() -> CGPoint {
    return CGPoint(x: self.maxX, y: self.maxY)
  }
}

public extension CGPoint {
  // passt die Koordinaten des Punkts so an, dass dieser sich
  // innerhalb des Rechtecks befindet
  func withinRect(_ rect: CGRect) -> CGPoint {
    return CGPoint(x: min(rect.maxX, max(rect.minX, self.x)),
                   y: min(rect.maxY, max(rect.minY, self.y)))
  }
  
  // Länge
  func length() -> CGFloat {
    return pythagoras(self.x,  self.y)
  }
  
  // Abstand
  func distanceTo(_ other: CGPoint) -> CGFloat {
    return pythagoras(self.x-other.x, self.y-other.y)
  }
  
  // Ausgabe mit zwei Nachkommastellen
  func print(_ txt: String) {
    let s = String(format: "\(txt) x=%.2f y=%.2f", self.x, self.y)
    Swift.print(s)
  }
}
