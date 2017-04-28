//
//  MyColor.swift
//  ios-split
//
//  Created by Michael Kofler on 31.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit

// Klasse, um eine Farbe samt Namen zu speichern
class MyColor {
  var name: String
  var color: UIColor
  
  init(_ name: String, color: UIColor) {
    self.name = name
    self.color = color
  }
  
  static func makeDefault() -> [MyColor] {
    return [
      MyColor("Gelb", color: .yellow),
      MyColor("Grau", color: .gray),
      MyColor("Rot", color: .red),
      MyColor("Grün", color: .green),
      MyColor("Blau", color: .blue)
    ]
  }
}
