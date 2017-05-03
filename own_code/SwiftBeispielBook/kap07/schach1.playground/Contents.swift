//: Playground - noun: a place where people can play

import Cocoa

struct ChessFigure {
  private var col = -1  // Spalte, Wertebereich 0-7 für a-h
  private var row = -1  // Zeile, Wertebereich 0-7 für 1-8
  var figure:String     // Art der Figur, z. B. "king"
  
  init(_ position:String, _ figure:String) {
    self.figure = figure
    self.position = position  // -> position-set
  }
  // Position in der üblichen Schach-Notation,
  // beispielsweise "a1" oder "e5" oder "h8"
  var position:String {
    get {      // Position zurückgeben
      if col == -1 || row == -1 { return "" }
      var position = ""
      position.append(Character(UnicodeScalar(97+col)))
      position.append(Character(UnicodeScalar(49+row)))
      return position
    }
    // Position in 'newValue' verarbeiten und in
    // row und col speichern, falls valid
    set {
      if newValue.unicodeScalars.count != 2 {
        row = -1; col = -1
      } else {
        let code1 =
          Int(newValue.lowercaseString
            .unicodeScalars.first!.value)
        let code2 = Int(newValue.unicodeScalars.last!.value)
        if code1<97 || code1>104 || code2<49 || code2>56 {
          row = -1; col = -1
        } else {
          col = code1 - 97
          row = code2 - 49
        }
      }
    } // set-Ende
  }   // var-Ende
}     // struct-Ende

// ChessFigure-Struktur ausprobieren
var king = ChessFigure("e1", "king")    // col=4, row=0
var dPawn = ChessFigure("d2", "pawn")   // col=3, row=1
dPawn.position                          // "d2"
var ePawn = ChessFigure("e2", "pawn")   // col=4, row=1
ePawn.position = "e4"                   // col=4, row=3
