//: Playground - noun: a place where people can play

import Foundation

// Erweiterung um eine find-Methode
extension Array {
  func find(condition: (Element) -> Bool) -> Int? {
    for i in 0 ..< self.count {
      if condition(self[i]) {
        return i
      }
    }
    return nil
  }
}

// Alternative zu Extensions:
// find als globale Funktion definieren
func find<T: Equatable>(data: [T], what: T) -> Int? {
  for i in 0 ..< data.count {
    if data[i] == what { return i }
  }
  return nil
}

// Anwendung der find-Methode
var ar = [7, 12, 30]
if let index = ar.find(condition: {$0 == 12})  {
  print("Gefunden an Position \(index)")
  // Ausgabe: 1 (also zweites Element)
}


// Anwendung der globalen find-Funktion
find(data: ar, what: 12)!   // 1 (also das zweite Element)
