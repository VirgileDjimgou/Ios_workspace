//: Playground - noun: a place where people can play

import Foundation

enum RectangleError : ErrorType {
  case LengthTooSmall
  case WidthTooSmall
}

// Struktur zur Speicherung eines Rechtecks
struct Rectangle {
  // interner Datenspeicher
  private var _length = 0.0
  private var _width = 0.0
  
  // init-Funktion, greift auf Computed Properties
  // zurück
  init(_ length:Double, _ width:Double) throws {
    _length = length
    _width = width
    if length < 0.0 { throw RectangleError.LengthTooSmall }
    if width < 0.0  { throw RectangleError.WidthTooSmall }
  }
  
  // Read-Only-Properties
  var length:Double { return _length }
  var width:Double  { return _width }
}

// Beispiel 1: ein korrektes Rechteck
do {
  let r = try Rectangle(1.2, 2.4)
  print(r.length)
} catch {
  print("Fehler: \(error)")
}

// Beispiel 2: in fehlerhaftes Rechteck
do {
  let r = try Rectangle(-1.2, 2.4)
  print(r.length)
} catch {
  print("Fehler: \(error)")
}



