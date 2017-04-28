//: Playground - noun: a place where people can play

import UIKit

// ganze Zahlen
if true {
  let imin = Int.min         // -9.223.372.036.854.775.808 (64 Bit)
  let imax = Int.max         //  9.223.372.036.854.775.807 (64 Bit)
  let i32min = Int32.min     //             -2.147.483.648
  let ui16max = UInt16.max   //                     65.535
  
  let x = 0b110011 // 51
  let y = 0o772    // 506
  let z = 0x12     // 18
  
  let bin = String(127, radix:2)   // "1111111"
  let oct = String(127, radix:8)   // "177"
  let hex = String(127, radix:16)  // "7f"
  
  let population = 7_287_726_818
  let id = 0x23a4_d350_5499_aaef
}

// Fließkommazahlen
if true {
  let x = 1.4          // normale Double-Zahl
  let y: Float = 1.3   // Float-Zahl mit reduzierter Genauigkeit
  
  let d1 = 1000.0     // 1000.0
  let d2 = 1e3        // 1000.0
  let d3 = 1.23e-2    // 1.23 * 10^-2 = 0.0123
  let d4 = 1.23E-2    // gleichwertig, 0.0123
  let d5 = 0x100p3    // 256 * 2^3 = 2048.0
  let d6 = 0xfp-2     // 15 * 2^-2 = 3,75
  
  sin(x)
  sin(y)
  hypot(1.0, 3.0)  // berechnet die Hypotenuse (Pythagoras)

 
}

// BinaryFloatingPoint-Protokoll
if true {
  var x = 1.23
  x.add(12)     // addiert 12 zu x, verändert x
  x.adding(12)  // addiert 12 zu x, verändert x nicht
  x.subtract(3)
  x.subtracting(3)
  x.isFinite
  x.isInfinite
  x
  x.squareRoot()  // berechnet die Wurzel, ändert x nicht
  x
  
  func sum<T: FloatingPoint>(_ a: T, _ b: T) -> T {
    return a.adding(b)
  }
  let a=2.0, b=3.0
  let c: Float = 2.0, d: Float = 3.0
  sum(a, b)
  sum(c, d)
}

// Typumwandlungen
if true {
  let x = 3                 // Datentyp Int
  let y = 2.2               // Datentyp Double
  // let z1 = x * y         // Fehler, nicht erlaubt
  let z2 = x * Int(y)       // 6
  let z3 = Double(x) * y    // 6.6
  let z4 = Int(2.9)         // 2
  let z5 = Int(-2.9)        // -2
  let z6 = Int(round(-2.9)) // -3
}

// Zufallszahlen
if true {
  arc4random_uniform(10)  // Zufallszahl zwischen 0 und 9
  let n = Int(arc4random_uniform(10))
  let m =  arc4random() // UInt32, 0 <= m <= 4294967295
  
  let x = Double(arc4random()) / Double(UInt32.max)
  
  var r: UInt64 = 0
  arc4random_buf(&r, 8)
  let y = Double(r) / Double(UInt64.max)

  srand48(Int(arc4random_uniform(10000000)))  // einmalig
  let r1 = drand48()   // beliebig oft, Wertebereich
  let r2 = drand48()   // 0 inklusive bis 1 exklusive
  
  func cRnd() -> CGFloat { return CGFloat(drand48()) }
  func dRnd() -> Double  { return drand48() }
  func iRnd(_ n: Int) -> Int {
    return Int(arc4random_uniform(UInt32(n)))
  }
  func initRnd() {  // drand48 initalisieren
    srand48(Int(arc4random_uniform(100000000)))
  }

}

// Boolsche Werte
if true {
  var result: Bool
  result = true
  result = !result
}


