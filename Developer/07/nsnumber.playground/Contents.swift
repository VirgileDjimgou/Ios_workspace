//: Playground - noun: a place where people can play

import UIKit

let n1 = NSNumber(value: 2.7)
let n2 = NSNumber(value: 17)
let n3 = NSNumber(value: true)
let n4 = NSNumber(value: arc4random())

n1.doubleValue  // 2.7
n1.intValue     // 2
n1.boolValue    // true
n2.doubleValue  // 17
n3.intValue     // 1 (bei false --> 0)
n4.intValue


var cnt = NSNumber(value: 1)
cnt = NSNumber(value: cnt.intValue + 1)  // Inkrement


