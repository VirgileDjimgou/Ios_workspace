import Foundation

// Basisklasse A mit den Eigenschaften a1 und a2
class A {
  var a1: Int
  var a2: Int
  
  init(a1: Int, a2: Int) {
    self.a1 = a1
    self.a2 = a2
  }
  func m() -> Int {  // Methode
    return a1 + a2
  }
  var p: Int {        // Computed Property
    get {
      return a1 + a2
    }
    set {
      a1 = 0
      a2 = newValue
    }
  }
}

// Spezialklasse B mit der zusätzlichen Eigenschaft b
class B : A {
  var b: Int
  
  init(a1: Int, a2: Int, b: Int) {
    self.b = b
    // Init-Funktion der Basisklasse aufrufen
    super.init(a1: a1, a2: a2)
  }
  
  // Methode überschreiben
  override func m() -> Int {
    // m1() der Basisklasse plus
    // B-spezifische Ergänzung
    return super.m() + b
  }
  
  // Computed Property überschreiben
  override var p: Int {
    get { return a1 + a2 + b }
    set {
      a1 = 0
      a2 = 0
      b  = newValue
    }
  }
}