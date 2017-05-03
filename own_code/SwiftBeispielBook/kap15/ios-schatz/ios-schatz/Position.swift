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
  var name:String
  var time:NSDate
  var lat:Double
  var long:Double

  init(_ name:String, _ time:NSDate, _ lat: Double, _ long:Double ) {
    self.name  = name
    self.time  = time
    self.lat   = lat
    self.long  = long
  }
  
  // für NSCoding-Protokoll
  required init?(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObjectForKey("name") as! String
    time = aDecoder.decodeObjectForKey("time") as! NSDate
    lat  = aDecoder.decodeDoubleForKey("lat")
    long = aDecoder.decodeDoubleForKey("long")
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(name, forKey: "name")
    aCoder.encodeObject(time, forKey: "time")
    aCoder.encodeDouble(lat,  forKey: "lat")
    aCoder.encodeDouble(long, forKey:"long")
  }
  
  // für Printable
  override var description:String {
    return name + "\(time) \(lat) \(long)"
  }
  
  // statische Methoden, um Position-Array
  // dauerhaft zu speichern bzw. wieder zu laden
  static func saveArrayToFile(data:[Position]) {
    if data.count==0 { return }
    if let path = getPath() {
      NSKeyedArchiver.archiveRootObject(data, toFile: path)
    }
  }
  static func readArrayFromFile() -> [Position] {
    if let path = getPath() {
      if let result = NSKeyedUnarchiver
          .unarchiveObjectWithFile(path) as? [Position]
      {
        return result
      }
    }
    return [Position]()  // leeres Array
  }

  // Pfad zur Datei "positions.bin" im
  // Document-Verzeichnis erstellen
  private static func getPath() -> String? {
    let pfd =       // Datentyp [String]
      NSSearchPathForDirectoriesInDomains(
        .DocumentDirectory, .UserDomainMask, true)
    if let path = pfd.first {
      return path + "/positions.bin"
    } else {
      return nil
    }
  }
  
}

