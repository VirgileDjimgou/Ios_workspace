//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


func f() -> Int         { return 1 }
func f(i: Int)          { print("f(i: Int)") }
func f(x: Double)       { print("f(x: Double)") }
func f(a: Int, b: Int)  { print("f(a: Int, b: Int)") }
func f(a: Int, c: Int)  { print("f(a: Int, c: Int)") }

func f() -> String { return "Hello!" }
func f(i: Int32)   { print("f(i: Int32)") }

// print( f() )  // Fehler, ambiguous use of f
let s: String = f()
print(s)