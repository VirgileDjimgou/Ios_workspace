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
  // Zugriff auf User Defaults
  static let defaults = NSUserDefaults.standardUserDefaults()

  // String-Array in User Defaults speichern
  static func save(data: [String]) {
    print("Todo.save()")
    defaults.setObject(data, forKey: "todolist")
  }

  // String-Array aus User Defaults lesen
  static func load() -> [String] {
    if let data = defaults.stringArrayForKey("todolist")  {
      return data
    } else {
      return [String]()  // leeres String-Array, wenn keine Daten gefunden werden
    }
  }
}
