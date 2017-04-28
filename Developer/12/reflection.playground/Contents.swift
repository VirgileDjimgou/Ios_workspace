import Cocoa

func f(_ obj: Any) -> String {
  if obj is Int {
    return "Integer"
  } else if obj is Double {
    return "Double"
  } else if obj is Date {
    return "Datum/Zeit"
  } else {
    return "weder noch"
  }
}

f(Date())

class A {}     // Basisklasse
class B: A {}  // B ist von A abgeleitet
class C: B {}  // C ist von B abgeleitet

let obj: A     // Variable vom Typ A
obj = C()      // Instanz vom Typ C

if obj is C {
  let c = obj as! C
}

if let c = obj as? C {
  // c hat den Datentyp C
} else {  // obj enthält keine Instanz des Typs C
  print("Fehler ...")
}



// Klasse als Testbasis
class MyClass {
  var a: Double = 1.0
  var b: Int = 2
  func f() -> Double { return a + Double(b) }
}

var x = MyClass()      // ein Objekt der Klasse
let mirr = Mirror(reflecting: x)
mirr.description       // Mirror for MyClass
mirr.children.count    // 2
for c in mirr.children {
  print("Label: \(c.label), Value: \(c.value)")
}
// Ausgabe: Label: Optional("a"), Value: 1.0
//          Label: Optional("b"), Value: 2


String(describing: type(of: x))  // "MyClass"


func typename(_ obj: Any) -> String {
  return String(describing: type(of: (obj)))
}

typename(x)            // "MyClass"
typename(2.4)          // "Double"
typename(Date())       // "Date"
typename([1, 2, 3])    // "Array<Int>"
typename( (1, 2, 3) )  // "(Int, Int, Int)"
