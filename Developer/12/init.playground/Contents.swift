//: Playground - noun: a place where people can play

import UIKit

class A {      // Basisklasse A
  var a1:Int, a2:Int
  init(_ a1:Int, _ a2:Int) {  // Designated Init Function
    self.a1=a1
    self.a2=a2
  }
  
  convenience init() {        // Convenience Init Function
    self.init(0, 0)           // mit Defaultwerten
  }
}

class B : A {  // erweiterte Klasse B
  var b:Int
  
  // Designated Init Function für B
  init(_ a1:Int, _ a2:Int, _ b:Int) {
    self.b = b
    
    // super.init(...) darf erst nach der Initialisierung
    // aller eigenen Eigenschaften (hier 'b')
    // aufgerufen werden. super.init() wäre
    // nicht erlaubt, weil init() nur eine
    // Convenience Init Function ist!
    super.init(a1, a2)
    
    // Der Zugriff auf Eigenschaften von A ist erst
    // hier, also nach super.init() zulässig.
    self.a1 += b
  }
  
  // Convenience Init Function für B
  convenience init() {
    // darf nur Init-Funktionen von B aufrufen,
    // aber keine Init-Funktionen von A!
    self.init(0, 0, 0)
  }
}
