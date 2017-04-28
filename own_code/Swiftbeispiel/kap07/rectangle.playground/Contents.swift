import Cocoa

// Struktur zur Speicherung eines Rechtecks
struct Rectangle {
  // interner Datenspeicher, 'private'
  private var _length = 0.0
  private var _width = 0.0
  
  // init-Funktion, greift auf Computed Properties
  // zurück
  init(_ length:Double, _ width:Double) {
    self.length = length
    self.width = width
  }
  
  // Computed Property 'length'
  var length:Double {
    // _length auslesen
    get {
      return _length
    }
    // _length verändern
    set {
      if newValue>0 {
        _length = newValue
      } else {
        NSException(name: "invalid argument",
          reason: "must be > 0", userInfo: nil).raise()
      }
    }
  }
  
  // Computed Property 'width' (analoger Code)
  var width:Double {
    get { return _width }
    set {
      if newValue>0 {
        _width = newValue
      } else {
        NSException(name: "invalid argument",
          reason: "must be > 0", userInfo: nil).raise()
      }
    }
  }
}

// Rectangle-Struktur ausprobieren
var r = Rectangle(1.2, 2.4)
r.length
r.length = 2.7



