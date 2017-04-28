
import Foundation

struct RegEx {
  let rx: NSRegularExpression!
  
  // RegEx-Struktur initialisieren
  init?(pattern: String,
        options: NSRegularExpression.Options = [])
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
             options: NSRegularExpression.MatchingOptions = [])
    -> Bool
  {
    return rx.numberOfMatches(
      in: string,
      options: options,
      range: NSMakeRange(0, string.utf16.count)) != 0
  }
}

// Anwendung der RexEx-Struktur: regulärer Ausdruck
// für Zeichenketten, die mit "A" beginnen
if let r = RegEx(pattern: "^A.*") {
  r.match(string: "Abc")      // true
  r.match(string: "abc")      // false
  r.match(string: "efgAbc")   // false
}
