//: Playground - noun: a place where people can play

import Foundation

// Basisklasse für eine allgemeine Schachfigur
class ChessFigure {
  var position: String
  
  required init(at position: String) {
    self.position = position
  }
  
  func toString() -> String {
    return "ChessFigure @ \(position)"
  }
}

// abgeleitete Klassen für Bauer und König
class Pawn : ChessFigure {
  override func toString() -> String {
    return "Pawn @ \(position)"
  }
}
class King : ChessFigure {
  var hasCastled = false  // Rochade
  override func toString() -> String {
    return "King @ \(position)"
  }
}

// impliziter Upcast
var cf1: ChessFigure = Pawn(at: "h2")
var cf2 = Pawn(at: "h2") as ChessFigure // gleichwertig

// Generalisierung: Obwohl Figures ein Array
// für ChessFigure-Elemente ist, dürfen darin
// auch Bauern, Könige etc. gespeichert werden:
var figures = [ChessFigure]()
figures.append(Pawn(at: "a2"))
figures.append(Pawn(at: "b2"))
figures.append(King(at: "b2"))

// Polymorphie: Es wird immer die 'richtige'
// toString-Methode aufgerufen:
for f in figures {
  print(f.toString())
}
// Ausgabe: Pawn @ a2
//          Pawn @ b2
//          King @ b2

if figures[1] is Pawn {           // Typtest
  let p = figures[1] as! Pawn     // impliziter Downcast mit as!,
  p.toString()                    // p hat den Datentyp 'Pawn'
}
if let k = figures[2] as? King {  // Typtest und Downcast
  print(k.hasCastled)             // zugleich mit as?,
  // liefert als Ergebnis false
}

