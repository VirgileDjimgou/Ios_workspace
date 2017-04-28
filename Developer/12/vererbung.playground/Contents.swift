//: Playground - noun: a place where people can play

import UIKit

class X {
  var a = 1, b=2
  func m1() -> Int {
    return a + b
  }
}
class Y : X {
  override var b: Int {
    get { return 3}
    set {}
  }
  override func m1() -> Int {
    return a * b
  }
}

var x = X()   // Instanz der Klasse X, a=1, b=2
var y = Y()   // Instanz der Klasse Y, a=1, b=2
x.m1()        // 1+2 ergibt 3
y.m1()        // 1*2 ergibt 2

class A {
  var x = 1
}
// B erweitert A um Property Observer
// für die Eigenschaft x
class B : A {
  override var x: Int {
    willSet(newX) { print("willSet: current=\(x) new will be=\(newX)") }
    didSet(oldX)  { print("didSet:  current=\(x) old was=\(oldX)") }
  }
}

var b = B()
b.x = 2


