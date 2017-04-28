//: Playground - noun: a place where people can play

import Cocoa



class Person : CustomStringConvertible, Hashable,
               Comparable, ExpressibleByStringLiteral
{
  var name: String
  var tel = [String]()
  var mail = [String]()
  init (_ name:String) {
    self.name=name
  }
  
  // die Implementierung dieser Eigenschaft ist
  // durch das CustomStringConvertible-Protokoll vorgeschrieben
  var description: String {
    let telnr = tel.joined(separator: ", ")
    let email = mail.joined(separator: ", ")
    return "\(name): \(telnr); \(email)"
  }
  
  // für das Protokoll Hashable (Eigenschaft)
  var hashValue: Int {
    var hash =  name.hashValue
    for t in tel  { hash ^= (t.hashValue &* 13) }
    for m in mail { hash ^= (m.hashValue &* 17) }
    return hash
  }
  
  // generische Typen für ExpressibleByStringLiteral
  typealias ExtendedGraphemeClusterLiteralType = String
  typealias UnicodeScalarLiteralType = String
  
  // Init-Funktionen für ExpressibleByStringLiteral
  required convenience init(stringLiteral name:
    StringLiteralType)
  {
    self.init(name)
  }
  
  required convenience init(extendedGraphemeClusterLiteral name:
    ExtendedGraphemeClusterLiteralType)
  {
    self.init(name)
  }
  
  required convenience init(unicodeScalarLiteral name:
    UnicodeScalarLiteralType)
  {
    self.init(name)
  }
}

// für das Protokoll Equatable (globale Funktion)
func ==(lhs: Person, rhs: Person) -> Bool {
  return lhs.name == rhs.name &&
         lhs.tel == rhs.tel &&
         lhs.mail == rhs.mail
}


// für das Protokoll Comparable (globale Funktion)
func <(lhs: Person, rhs: Person) -> Bool {
  return lhs.name < rhs.name
}

// Test
var p = Person("Hermann Huber")
p.tel.append("0123 5325345")
p.tel.append("0699 44556677")
p.mail.append("hermann@huber.com")
print(p)
// Ausgabe:
// "Hermann Huber: 0123 5325345, 0699 44556677; hermann@huber.com"


var p1 = Person("Harald Hosp")
var p2 = Person("Hermann Huber")
p1==p2   // false
p1<p2    // true
p1<=p2   // true
p1>p2    // false
p1>=p2   // false

// Test von StringLiteralConcertible
var p3:Person
p3 = "Margareta Maier"
p3.tel.append("0123 4587234")

// description bei Klassen, die von NSObject abgeleitet sind
class Person2: NSObject {
  var vorname: String
  var nachname: String
  init(vorname: String, nachname: String) {
    self.vorname = vorname
    self.nachname = nachname
  }
  override var description: String {
    return "\(vorname) \(nachname)"
  }
}
let t = Person2(vorname: "Hermann", nachname: "Huber")
print(t)  // Ausgabe "Hermann Huber"

