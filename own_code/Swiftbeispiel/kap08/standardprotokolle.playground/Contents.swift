//: Playground - noun: a place where people can play

import UIKit

func f1(all:Any ...) {
  for p in all {
    if let i = p as? Int {
      print("  Integer: \(i)")
    } else if let d = p as? Double {
      print("  Double: \(d)")
    } else if let s = p as? String {
      print("  String: \(s)")
    } else {
      print("  Sonstige: " + String(p.dynamicType))
    }
  }
}

// Test
f1(8, 2.5, "abc", false, NSDate())
// Ausgabe: Integer: 8
//          Double: 2.5
//          String: abc
//          Sonstige: Swift.Bool
//          Sonstige: NSDate

func f2(all:AnyObject ...) {
  for p in all {
    print(String(p.dynamicType), terminator: "   ")
    if let i = p as? Int {
      print("  Integer: \(i)")
    } else if let d = p as? Double {
      print("  Double: \(d)")
    } else if let s = p as? String {
      print("  String: \(s)")
    } else {
      print("  Sonstige: " + String(p.dynamicType))
    }
  }
}
// Test
f2(8, 2.5, "abc", false, NSDate())
// Ausgabe:
// __NSCFNumber                Integer: 8
// __NSCFNumber                Integer: 2
// _NSContiguousString         String: abc
// __NSCFBoolean               Integer: 0
// __NSTaggedDate              Sonstige: __NSTaggedDate
