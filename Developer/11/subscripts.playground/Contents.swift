//: Playground - noun: a place where people can play

import UIKit

var ar = [17, 29, 31, 47]
ar[2]                          // 31, Datentyp Int

var dict = ["GRZ": "Graz", "VIE": "Wien", "SZG": "Salzburg"]
dict["VIE"]                    // "Wien", Datentyp String?

var s = "Hello World!"
let start = s.startIndex
let end = s.index(start, offsetBy: 3)
s[start..<end]                 // "Hell", Datentyp String

