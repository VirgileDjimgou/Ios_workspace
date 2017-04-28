import Cocoa

struct Vector3 {
  var x = 0.0
  var y = 0.0
  var z = 0.0
  
  // Null-Vektor zurückgeben
  static let zero = Vector3(x: 0, y: 0, z: 0)
  
  // liefert die Länge des Vektors als Double-Zahl
  func length() -> Double {
    return sqrt(x * x + y * y + z * z)
  }
  
  // erzeugt neue Vector3D-Instanz
  func getNormalized() -> Vector3? {
    if length() > 0 {
      return Vector3(x: x / length(),
                     y: y / length(),
                     z: z / length())
    } else {
      return nil
    }
  }
  
  // vorhandenen Vektor normalisieren
  mutating func normalize() {
    let len = length()
    if len != 0 {
      x = x / len   //  Fehler: cannot assign to x in self
      y = y / len
      z = z / len
    }
  }
  
  // Mutating Method, um x-, y- und z-Offset zum
  // Vektor zu addieren
  mutating func add(xoffset: Double,
                    yoffset: Double,
                    zoffset: Double)
  {
    self = Vector3(x: x + xoffset,
                   y: y + yoffset,
                   z: z + zoffset)
  }
  
  // gibt die Vektorkomponenten als Zeichenkette zurück
  func toString() -> String {
    return "(\(x), \(y), \(z))"
  }
  
  // Instanz-Methode, liefert true, wenn self länger 
  // als other ist
  func greater(than other: Vector3) -> Bool {
    return self.length() > other.length()
  }

  // Instanz-Methode, liefert true, wenn self kürzer
  // als other ist
  func smaller(than other: Vector3) -> Bool {
    return self.length() < other.length()
  }
  
  
  // statische Methode, liefert true, wenn v1 länger
  // als v2 ist
  static func greater(v1: Vector3, v2: Vector3) -> Bool {
    return v1.length() > v2.length()
  }
  // statische Methode, liefert true, wenn v1 kürzer
  // als v2 ist
  static func smaller(v1: Vector3, v2: Vector3) -> Bool {
    return v1.length() < v2.length()
  }
  
  
}

func < (lhs: Vector3, rhs: Vector3) -> Bool {
  return lhs.smaller(than: rhs)
}
func > (lhs: Vector3, rhs: Vector3) -> Bool {
  return lhs.greater(than: rhs)
}

// ausprobieren
let v0 = Vector3.zero
let v0b = Vector3()

let v1 = Vector3(x: 2, y: 3, z: 1)
v1.length()    // 3,7417

let v2 = v1.getNormalized()!
v2.toString()  // "(0.5345, 0.8018, 0.2673)"
v2.length()    // 1,0

v1.greater(than: v2)  // true

var v3 = Vector3(x: 1, y: 2, z: 3)
v3.normalize()
v3.toString()  // "(0,2673, 0,5345, 0,8018)"
v3.add(xoffset: 1, yoffset: 1, zoffset: 1)
v3.toString()  // "(1,2673, 1,5345, 1,8018)"

// Vektoren nach Länge sortieren
var v = [Vector3]()
v.append(Vector3(x: 1, y: 2, z: 3))
v.append(Vector3(x: 2, y: 2, z: 3))
v.append(Vector3(x: 1, y: 0, z: 1))

// sortiert das Array v, der längste Vektor wird
// zuerst aufgelistet
v.sort(by: Vector3.greater)
for item in v {
  print(item.toString())
}


// sortiert das Array in umgekehrter Reihenfolge
v.sort(by: Vector3.smaller)
for item in v {
  print(item.toString())
}



v.sort(by: <)
for item in v {
  print(item.toString())
}

