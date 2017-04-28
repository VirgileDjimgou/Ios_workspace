//: Playground - noun: a place where people can play

import Foundation

let date = NSDate()
let cal = NSCalendar.currentCalendar()
let comps = cal.components([.Hour, .Month, .Day, .Year],
  fromDate: date)
comps.year
comps.month
comps.day
comps.hour

struct MyOptions : OptionSetType {
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

let someOptions1:MyOptions = [.A, .C]
let someOptions2:MyOptions = [.A, .B, .D]
let someOptions3:MyOptions = [.BD]
let someOptions4:MyOptions = []

func testIfAC(opt: MyOptions) -> Bool {
  return opt.exclusiveOr([.A, .C]) == []
}

testIfAC(someOptions1)  // true
testIfAC(someOptions2)  // false
testIfAC(someOptions3)  // false
testIfAC(someOptions4)  // false
