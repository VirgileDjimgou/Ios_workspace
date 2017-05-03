//: Playground - noun: a place where people can play

import Foundation

// Datei regex.playground
struct RegEx {
  let rx: NSRegularExpression!
  
  // RegEx-Struktur initialisieren
  init?(pattern: String,
    options: NSRegularExpressionOptions = [])
  {
    do {rx = try NSRegularExpression(
      pattern: pattern, options: options)
    } catch {
      print("Fehlerhafter regulärer Ausdruck")
      return nil
    }
  }
  
  // match-Methode zur Anwendung des regulären Ausdrucks
  func match(string: String,
    options: NSMatchingOptions = []) -> Bool
  {
    return rx.numberOfMatchesInString(
      string,
      options: options,
      range: NSMakeRange(0, string.utf16.count)) != 0
  }
}

// Anwendung der RexEx-Struktur: regulärer Ausdruck
// für Zeichenketten, die mit "A" beginnen
if let r = RegEx(pattern: "^A.*") {
  r.match("Abc")      // true
  r.match("abc")      // false
  r.match("efgAbc")   // false
}