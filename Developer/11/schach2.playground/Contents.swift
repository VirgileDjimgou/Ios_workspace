//: Playground - noun: a place where people can play

// Aufzählungen zur Definition der Schachfiguren
enum Pieces { case king, queen, rook, bishop, knight, pawn }
enum Colors { case white, black }

// Struktur zur Darstellung einer Schachfigur (ohne Position)
struct Figure {
  let col: Colors
  let fig: Pieces
  init(_ col: Colors, _ fig: Pieces) {
    self.col = col
    self.fig = fig
  }
}

// Schachbrett zur Speicherung der Figuren
struct ChessBoard {
  // internr Datenspeicher
  private var _board:[[Figure?]]
  
  // Initialisierung des 8x8-Arrays
  init() {
    _board = [[Figure?]](repeating: [Figure?](repeating: nil,
                                              count: 8),
                         count: 8)
  }
  
  // subscript-Funktionen zum komfortablen Zugriff
  // auf das Schachbrett
  subscript(pos: String) -> Figure? {
    get {
      let (row, col) = ChessBoard.getColRow(pos: pos)
      return _board[row][col]
    }
    set(newValue) {
      let (row, col) = ChessBoard.getColRow(pos: pos)
      _board[row][col] = newValue
    }
  }
  
  // Umrechnung "e3" --> (4, 2)
  private static func getColRow(pos:String) -> (Int, Int) {
    if pos.unicodeScalars.count != 2 {
      print("wrong position")
      return (-1, -1)
    }
    
    let code1 =
      Int(pos.lowercased().unicodeScalars.first!.value)
    let code2 = Int(pos.unicodeScalars.last!.value)
    if code1>=97 && code1<=104 && code2>=49 && code2<=56 {
      return (code1 - 97, code2 - 49)
    } else {
      print("wrong position")
      return (-1, -1)
    }
    
  }
}

// ChessBoard-Struktur ausprobieren
var cb = ChessBoard()
cb["a1"] = Figure(.white, .rook)  // weißer Turm auf a1
cb["h8"] = Figure(.black, .rook)  // schwarzer Turm auf h8
// auslesen
cb["a1"]?.col                     // white
cb["a1"]?.fig                     // rook



