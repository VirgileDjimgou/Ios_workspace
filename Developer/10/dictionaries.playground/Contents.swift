//: Playground - noun: a place where people can play

import UIKit

var dict = ["rot": "red", "grün": "green"]
dict["blau"] = "blue"  // Element hinzufügen/ändern
dict["rot"]            // Elementzugriff --> "red" als String?
dict["green"]          // ungültiger Elementzugriff --> nil

dict["blau"] = nil     // Element entfernen
dict.removeAll()       // alle Elemente entfernen

var colors = [String: Int]()
colors["red"] = 0xff0000
colors["blue"] = 0x0000ff

// für das vorhin definierte Dictionary colors
if let col = colors["red"] {      // Int? --> Int
  // ...
}
var mycol = colors["blue"] ?? 0;  // Default-Farbcode 0

for s in colors.keys {
  print(s)
}  // Ausgabe: blue, white, red
for i in colors.values {
  print(i)
}  // Ausgabe: 255, 16777215, 16711680

for (cname, ccode) in colors {
  print("Name \(cname) -- Code \(String(ccode, radix:16))")
}
// Ausgabe: Name blue  -- Code ff
//          Name white -- Code ffffff
//          Name red   -- Code ff0000
