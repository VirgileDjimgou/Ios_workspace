//: Playground - noun: a place where people can play

import UIKit

// Geometry-Protokoll
@objc protocol Geometry  {
  var area:Double {get}                 // zwingend erforderlich
  @objc optional var perimeter:Double {get}   // freiwillig
  @objc optional func m() -> Double           // freiwillig
}

// Quadrat-Klasse
class Square : Geometry {
  var side: Double
  init(_ s: Double) { side = s }
  @objc var area: Double  { return side*side }
}

var s:Geometry = Square(2.4)
s.area         // 5,76
s.perimeter    // nil, weil von 'Square' nicht implementiert
s.m?()         // ebenfalls nil

