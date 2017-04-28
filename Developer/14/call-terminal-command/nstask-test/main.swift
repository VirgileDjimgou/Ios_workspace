//
//  main.swift

import Foundation

// mit dem find-Kommando alle Dateien in /usr/bin suchen
let pipe = Pipe()
let task = Process()
task.launchPath = "/usr/bin/find"
task.arguments = ["/usr/bin", "-type", "f"]
task.standardOutput = pipe
task.launch()

// Ergebnis von find zeilenweise ausgeben

// Datentyp data (binäre Daten)
let data = pipe.fileHandleForReading.readDataToEndOfFile()

// in Zeichenkette umwandeln
if let s = String(bytes: data, encoding: .utf8) {
  // zeilenweise ausgeben
  let lines = s.components(separatedBy: "\n")
  for line in lines {
    print(line)
  }
}

