//: Playground - noun: a place where people can play

import UIKit

struct Triple<T> {
  var a: T, b: T, c: T
  init (_ a: T, _ b: T, _ c: T) {
    self.a = a
    self.b = b
    self.c = c
  }
}
var t1 = Triple(1, 2, 3)             // Datentyp Triple<Int>
var t2 = Triple("abc", "efg", "xyz") // Datentyp Triple<String>
var t3 = Triple<UInt64>(1, 2, 3)     // Datentyp Triple<UInt64>
t3.b                                 // 2, Datentyp UInt64

// Regeln für generische Typen (Syntaxbeispiele)
protocol P1 {}
protocol P2 {}
protocol P3 {}

struct MyStruct1<T: P1> { }
struct MyStruct2<T: P1 & P2 & P3> { }

class MyClass { }
func myFunc<T: MyClass>(element: T, n: Int) -> Int { return 1 }

func toArray<S : Sequence, T> (_ seq : S)
  -> [T]
  where T == S.Iterator.Element
{
  var ar = [T]()
  for x in seq {
    ar.append(x)
  }
  return ar
}
let ar = toArray("abc".characters)  // ["a", "b", "c"]

// es geht auch ohne toArray :-)
let ar2 = Array("abc".characters)

// generische Typ-Aliase
typealias Temperature = Double
var temp: Temperature = 2.7
2.3 + Temperature(2.5)      // 4.8, entspricht 2.3 + Double(2.5)


typealias StringDictionary<T> = Dictionary<String, T>
typealias IntFunction<T> = (T) -> Int
typealias MatchingTriple<T> = (T, T, T)
typealias BackwardTriple<T1,T2,T3> = (T3, T2, T1)



