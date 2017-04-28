//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// Basisklasse
class A {
  var a1: Int, a2: Int
  
  // jede Subklasse muss diese Init-Funktion
  // auch implementieren
  required init(_ a1: Int, _ a2: Int) {
    self.a1 = a1
    self.a2 = a2
  }
}

// erweiterte Klasse B
class B : A {
  var b: Int
  
  // Designated Init Function zur Initialisierung
  // aller Eigenschaften von A und B
  init(_ a1: Int, _ a2: Int, _ b: Int) {
    self.b = b
    super.init(a1, a2)
  }
  
  // Convenience Init Function, erfüllt zugleich
  // die 'required'-Anforderung aus A
  required convenience init(_ a1: Int, _ a2: Int) {
    self.init(a1, a2, 0)
  }
}


// Redundanz vermeiden mit optionalen Eigenschaften
class ViewController: UIViewController {
  var x: Int!, y: Int!, z: Int!
  
  override init(nibName nibNameOrNil: String?,
                bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    sharedInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    sharedInit()
  }
  
  // zentrale Initialisierung optionaler Eigenschaften
  func sharedInit() {
    x = 1; y = 2; z = 3
  }
}
