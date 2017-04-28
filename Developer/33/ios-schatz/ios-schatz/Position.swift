//
//  Position.swift
//  ios-schatz
//
//  Created by Michael Kofler on 18.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Foundation

// Klasse zur Speicherung einer Ortsangabe, bestehend
// aus Name, Zeitpunkt, sowie geogr. Breite + Länge
class Position:  NSObject, NSCoding {
  var name: String
  var time: Date
  var lat: Double
  var long: Double

  init(_ name:String, _ time:Date, _ lat: Double, _ long:Double ) {
    self.name  = name
    self.time  = time
    self.lat   = lat
    self.long  = long
  }
  
  // für NSCoding-Protokoll
  required init?(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObject(forKey: "name") as! String
    time = aDecoder.decodeObject(forKey: "time") as! Date
    lat  = aDecoder.decodeDouble(forKey: "lat")
    long = aDecoder.decodeDouble(forKey: "long")
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "name")
    aCoder.encode(time, forKey: "time")
    aCoder.encode(lat,  forKey: "lat")
    aCoder.encode(long, forKey: "long")
  }
  
  // für Printable
  override var description:String {
    return name + "\(time) \(lat) \(long)"
  }
  
  
  // statische Methoden, um Position-Array
  // dauerhaft zu speichern bzw. wieder zu laden
  static func saveArrayToFile(_ data:[Position]) {
    if data.count == 0 { return }
    if let path = docPath(for: "positions.bin") {
      _ = NSKeyedArchiver.archiveRootObject(data, toFile: path)
    }
  }
  static func readArrayFromFile() -> [Position] {
    if let path = docPath(for: "positions.bin"),
       let result = NSKeyedUnarchiver
        .unarchiveObject(withFile: path) as? [Position]
    {
      return result
    }
    return [Position]()  // leeres Array
  }

  // liefert URL für Datei im Documents-Verzeichnis
  private static func docPath(for filename: String) -> String? {
    // sollte immer genau ein Ergebnis liefern
    let urls = FileManager.default.urls(for: .documentDirectory,
                                        in: .userDomainMask)
    if let docDir = urls.first {
      return docDir.appendingPathComponent(filename).path
    }
    return nil
  }

  
}

