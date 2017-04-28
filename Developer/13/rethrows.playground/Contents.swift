//: Playground - noun: a place where people can play

import UIKit

//: ##  Fehler in Closures

enum MyErrors : Error {
  case tooSmall
  case tooBig(maximum: Int)
  case missing
  case other(explanation: String)
}

func f1(_ n: Int) throws -> Int {
  if n < 0   { throw MyErrors.tooSmall }
  if n > 100 { throw MyErrors.tooBig(maximum: 100) }
  return n + 1
}


let data = [1, 2, 3, 200]

// keine Absicherung notwendig, new1 hat den Datentyp [Int]
// Ergebnis [2, 3, 4, 201]
let new1 = data.map() { $0 + 1}

// Fehler, muss mit try abgesichert werden
// let new2 = data.map(f1)

// new3 hat den Datentyp [Int]?, Ergebnis nil
let new3 = try? data.map(f1)
print(new3 as Any)

// ist nicht gleichwertig zu map(f1), funktioniert
// nicht, weil Closures nicht mit rethrows gekennzeichnet
// werden können
// let new4 = try? data.map() {  f1($0) }


// OK, new5 hat den Datentyp [Int?], Ergebnis
// [Optional(2), Optional(3), Optional(4), nil]
let new5 = data.map() { try? f1($0) }
new5


// map selbst definiert, zuerst ohne rethrows
extension Array {
  func map1<T>(_ transform: (Element) -> T) -> [T] {
    var result = [T]()
    for item in self {
      result.append(transform(item))
    }
    return result
  }
}

// Test
let new6 = data.map1() { $0 + 10 }
new6

// neues map, jetzt mit rethrows
extension Array {
  func map2<T>(_ transform: (Element) throws -> T) rethrows -> [T] {
    var result = [T]()
    for item in self {
      do {
        let newitem = try transform(item)
        result.append(newitem)
      } catch {
        throw error
      }
    }
    return result
  }
}

// Kurzfassung
extension Array {
  func map3<T>(_ transform: (Element) throws -> T) rethrows -> [T] {
    var result = [T]()
    for item in self {
      let newitem = try transform(item)
      result.append(newitem)
    }
    return result
  }
}

let new7 = try? data.map3(f1)           // nil
let new8 = data.map3() { try? f1($0) }  // [Optional(2), Optional(3), Optional(4), nil]
new8

