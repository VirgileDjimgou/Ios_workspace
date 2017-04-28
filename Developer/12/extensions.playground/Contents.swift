//: Playground - noun: a place where people can play

import UIKit

struct MyType {}
protocol Protocol1 {}
protocol Protocol2 {}

extension MyType {
  // Code, der die Klasse, Struktur oder Enumeration
  // 'MyType' erweitert
}

extension MyType : Protocol1, Protocol2 {
  // Code für zusätzliche Eigenschaften und Methoden,
  // damit 'MyType' die Regeln von 'Protocol1' und
  // 'Protocol2' einhält
}

struct Person  {
  var name: String
  init(_ name: String) {
    self.name = name
  }
  var description: String {
    return name
  }
}
// nachträgliche Erweiterung von 'Person' um
// das Protokoll 'CustomStringConvertible'
extension Person : CustomStringConvertible {
  // kein Code erforderlich
}

// die vorhandene Car-Struktur ...
struct Car {
  var model: String
  var typenr: String
}

// ... soll nachträglich erweitert werden
extension Car : Equatable { }

func == (lhs: Car, rhs: Car) -> Bool {
  return lhs.model == rhs.model &&
    lhs.typenr == rhs.typenr
}


//: ## Protokollerweiterungen

protocol MyProtocol {
  func methodA() -> Double
  func methodB() -> Int
}

// Erweiterung des Protokolls
extension MyProtocol {
  // neue Methode
  func methodC() -> Double {
    return methodA() + Double(methodB())
  }
  // neue Computed Property
  var propertyD: Int {
    get { return 3 }
  }
}

struct MyStruct : MyProtocol {
  // durch MyProtocol vorgeschrieben
  func methodA() -> Double { return 1.2 }
  func methodB() -> Int    { return 3 }
  // Erweiterung, Defaultimplementierung wird
  // durch eigenen Code ersetzt
  func methodC() -> Double { return 2.2 }
}


