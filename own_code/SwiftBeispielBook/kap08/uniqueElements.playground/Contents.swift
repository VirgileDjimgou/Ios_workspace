//: Playground - noun: a place where people can play

import UIKit

extension CollectionType where Generator.Element : Comparable {
  func uniqueElements() -> [Generator.Element] {
    // Ergebnis: ein vorerst leeres Array
    // für Elemente vom Typ Generator.Element
    var result : [Generator.Element] = []
    
    // gegebenenfalls leeres Array zurückgeben
    if self.count == 0 { return result }
    
    // Schleife über alle Elemente von self
    var index = self.startIndex
    repeat {
      // Element zu result hinzufügen, wenn es
      // noch nicht enthalten ist
      if !result.contains( self[index] ) {
        result.append(self[index])
      }
      index = index.successor()
    } while index != self.endIndex
    
    return result
  }
}

var ar = Array("Hello World!".characters)
ar.uniqueElements()
// Ergebnis: ["H", "e", "l", "o", " ", "W", "r", "d", "!"]

extension CollectionType where Generator.Element : Hashable {
  func uniqueSet() -> Set<Generator.Element> {
    // Ergebnis: ein vorerst leeres Set
    // für Elemente vom Typ Generator.Element
    var result = Set<Generator.Element>()
    
    // gegebenenfalls leeres Set zurückgeben
    if self.count == 0 { return result }
    
    // Schleife über alle Elemente von self
    var index = self.startIndex
    repeat {
      // Element zu result hinzufügen, wenn es
      // noch nicht enthalten ist
      result.insert(self[index])
      index = index.successor()
    } while index != self.endIndex
    
    return result
  }
}

ar.uniqueSet()
