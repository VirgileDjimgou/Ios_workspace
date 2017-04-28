import Cocoa


// Klasse als Testbasis
class MyClass {
  var a:Double = 1.0
  var b:Int = 2
  func f() -> Double { return a+Double(b) }
}

var x = MyClass()      // ein Objekt der Klasse
let mirr = Mirror(reflecting: x)
mirr.description       // Mirror for MyClass
mirr.children.count    // 2
for c in mirr.children {
  print("Label: \(c.label), Value: \(c.value)")
}
// Ausgabe: Label: Optional("a"), Value: 1.0
//          Label: Optional("b"), Value 2


String(x.dynamicType)  // MyClass

// in Swift 2.2 gestrichen
// _stdlib_getDemangledTypeName(x)  // "MyClass"


func demangle (obj:Any) -> String{
  // return _stdlib_getDemangledTypeName(obj)
  return String(obj.dynamicType)
}
demangle(x)            // "MyClass"
demangle(2.4)          // "Double"
demangle(NSDate())     // "__NSDate"
demangle([1, 2, 3])    // "Array<Int>"
demangle( (1, 2, 3) )  // "(Int, Int, Int)"
