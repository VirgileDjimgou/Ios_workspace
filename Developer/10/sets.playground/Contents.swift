//: Playground - noun: a place where people can play

import UIKit

var set = Set<Int>()        // leeres Set erzeugen
repeat {                    // Lottozahlen einfügen
  set.insert(Int(arc4random_uniform(49))+1)
} while set.count<6

var lotto = Array(set).sorted()
print(lotto)               // z. B.: [27, 28, 39, 42, 46, 47]

// OptionSets
struct MyOptions: OptionSet {
  let rawValue: Int
  init(rawValue: Int) {
    self.rawValue = rawValue
  }
  
  static let A = MyOptions(rawValue: 1)
  static let B = MyOptions(rawValue: 2)
  static let C = MyOptions(rawValue: 4)
  static let D = MyOptions(rawValue: 8)
  
  // vordefinierte Kombination, die häufig
  // benötigt wird
  static let BD: MyOptions = [B, D]
}

let someOptions1: MyOptions = [.A, .C]
let someOptions2: MyOptions = [.A, .B, .D]
let someOptions3: MyOptions = [.BD]
let someOptions4: MyOptions = []

func testIfAC(_ opt: MyOptions) -> Bool {
  return opt.contains(.A) && opt.contains(.C)
}

testIfAC(someOptions1)  // true
testIfAC(someOptions2)  // false
testIfAC(someOptions3)  // false
testIfAC(someOptions4)  // false
