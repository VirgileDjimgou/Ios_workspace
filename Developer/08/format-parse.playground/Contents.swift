//: Playground - noun: a place where people can play

import UIKit


// Python-ähnlicher %-Operator
func % (format:String, args: [CVarArg]) -> String {
  return String(format: format,  arguments:args)
}


if true {
  let x = 2.0
  let sq = sqrt(x)
  
  // String-Interpolation
  let s1 = "Die Wurzel von \(x) beträgt \(sq)."
  // s1 = "Die Wurzel von 2.0 beträgt 1.4142135623731."

  // printf-Formatierung
  let fmt = "Die Wurzel von %.3f beträgt %.3f."
  let s2 = String(format:fmt, x, sq)
  // s2 = "Die Wurzel von 2.000 beträgt 1.414."

  // Python-ähnliche Formatierung
  let s3 = fmt % [x, sq]
  // s3 = "Die Wurzel von 2.000 beträgt 1.414."

  // deutsche Formatierung erzwingen
  print(Locale.current.identifier)  // im Playground gilt immer "en_US"
  let de = Locale(identifier: "de_DE")
  let s4 = String(format:fmt, locale: de,  x, sq)
  // s4 = "Die Wurzel von 2,000 beträgt 1,414."

}

// NumberFormatter
if true {
  let fmt = NumberFormatter()
  fmt.locale = Locale(identifier: "de_DE")
  fmt.usesGroupingSeparator=true
  fmt.string(from: 1234567)     // 1.234.567
  fmt.minimumFractionDigits = 2
  fmt.maximumFractionDigits = 2
  fmt.string(from: 1234.567)    // 1.234,57
  fmt.string(from: 1234)        // 1.234,00
}


// Zeichenketten in Zahlen umwandeln (parsen)
if true {
  Int("123")      // 123
  Int("123abc")   // nil
  Int("12e3")     // nil
  Int("123 ")     // nil
  Int(" 123")     // nil

  let s = "123"
  let n = Int(s) ?? 0  // Datentyp Int
  let m = Int(s)       //          Int?
  let o = m! + 3       //          Int
  
  Double("123.5")                  //  132,5 (Datentyp Double?)
  Double("123,5")                  //    nil
  Double("abc")                    //    nil
  
  
  let fmt = NumberFormatter()
  fmt.numberStyle = .decimal
  fmt.locale = Locale(identifier: "de_DE")
  fmt.number(from: "1.234.567,89")      // 1234567,89 als NSNumber?
  fmt.number(from: "abc")               // nil        als NSNumber?
  if let x = fmt.number(from: "3,14159")  {
    // x enthält 3,14159, Datentyp NSNumber
    let y = x.doubleValue + 1.2          // 4,34159 als Double
  }
}
