//: Playground - noun: a place where people can play

import UIKit

extension Collection where Iterator.Element : Comparable {
  
  // liefert Array zurück, das jedes Element nur einmal enthält
  func uniqueElements() -> [Iterator.Element] {
    // Ergebnis: ein vorerst leeres Array
    // für Elemente vom Typ Generator.Element
    var result : [Iterator.Element] = []
    
    // gegebenenfalls leeres Array zurückgeben
    if self.count == 0 { return result }
    
    // die Schleife über alle Elemente von self ist
    // möglich, weil Collection das IteratorProtocol
    // implementiert
    for  e in self {
      if !result.contains(e) {
        result.append(e)
      }
    }
    
    return result
  }
}

var ar = Array("Hello World!".characters)
ar.uniqueElements()
// Ergebnis: ["H", "e", "l", "o", " ", "W", "r", "d", "!"]

extension Collection where Iterator.Element : Hashable {
  
  // liefert Set zurück
  func uniqueSet() -> Set<Iterator.Element> {
    // Ergebnis: ein vorerst leeres Set
    // für Elemente vom Typ Generator.Element
    var result = Set<Iterator.Element>()
    
    // gegebenenfalls leeres Set zurückgeben
    if self.count == 0 { return result }
    
    // Schleife über alle Elemente von self
    for e in self {
      result.insert(e)
    }
    
    return result
  }
}

ar.uniqueSet()

