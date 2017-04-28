//
//  Todo.swift
//  ios-list4
//
//  Created by Michael Kofler on 29.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Foundation

// Hilfsfunktionen, um Todo-Liste zu speichern bzw. zu laden
struct Todo {
  // String-Array in der Datei "todo.txt"
  // im Documents-Verzeichnis speichern
  static func save(_ data: [String]) {
    if let url = docUrl(for: "todo.txt") {
      do {
        // Array in eine lange Zeichenkette
        // umwandeln
        let str = data.joined(separator: "\n")
        try str.write(to: url,
                      atomically: true,
                      encoding: .utf8)
      } catch  {
        print(error)
      }
    }
  }

  // String-Array aus "todo.txt" laden
  static func load() -> [String] {
    if let url = docUrl(for: "todo.txt") {
      do {
        let str = try String(contentsOf: url,
                             encoding: .utf8)
        // Zeilen der Zeichenkette in ein
        // String-Array umwandeln und zurückgeben
        return str.characters
          .split { $0 == "\n" }
          .map { String($0) }
      } catch  {
        print(error)
      }
    }
    return []
  }

  // liefert URL für Datei im Documents-Verzeichnis
  private static func docUrl(for filename: String) -> URL? {
    // sollte immer genau ein Ergebnis liefern
    let urls = FileManager.default.urls(for: .documentDirectory,
                                        in: .userDomainMask)
    if let docDir = urls.first {
      return docDir.appendingPathComponent(filename)
    }
    return nil
  }

  
}
