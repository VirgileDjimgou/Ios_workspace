//
//  main.swift
//  macos-file
//
//  Created by Michael Kofler on 23.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import Foundation

// Heimatverzeichnis /User/<account> ermitteln
let homepath = NSHomeDirectory()
print(homepath)

// Dateien ohne Rekursion durchlaufen
let fm = FileManager.default
if let files = try? fm.contentsOfDirectory(atPath: homepath) {
  for file in files {
    print(file)
  }
}




// Größe einer Datei ermitteln
func fileSize(path: String) -> Int64? {
  if let attr = try? fm.attributesOfItem(atPath: path) {
    if let nmb = attr[.size] as? NSNumber  {
      return nmb.int64Value
    }
  }
  return nil
}


// Summe der Größe aller Dateien rekursiv ermittlen
func dirSize(at dirpath: String) -> Int64 {
  print(".", terminator: "")
  var result: Int64 = 0
  // Verzeichniseinträge ermitteln
  if let paths = try? fm.contentsOfDirectory(atPath: dirpath) {
    // alle Elemente durchlaufen, test ob Verzeichnis/Datei
    for path in paths {
      let fullpath = dirpath + "/" + path
      var isDir : ObjCBool = false
      if fm.fileExists(atPath: fullpath,
                       isDirectory: &isDir)
      {
        if isDir.boolValue {
          // es ist ein Verzeichnis --> auch
          // dessen Inhalt verarbeiten
          result += dirSize(at: fullpath)
        } else {
          // es ist eine Datei: deren
          // Größe hinzufügen
          if let size = fileSize(path: fullpath) {
            result += size
          }
        }
      }   // Ende if-fileExists
    }     // Ende for-path
  }       // Ende if-let-try
  return result
}

// // rekursiv Größe des Documents-Verzeichnis ermitteln
// let doc = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
// let totalsize = dirSize(at: doc.path)
// print()
// print("\(totalsize) Byte")

// VORSICHT: Im Debug-Modus ist das Programm relativ langsam
// und scheint laut Debug-Navigator irrwitzig viel Speicher zu 
// beanspruchen. Wenn Sie größere Verzeichnisse durchlaufen, 
// erstellen Sie eine Release-Version! Siehe auch:
// http://stackoverflow.com/questions/28321954/ios-memory-usage-increasing-cant-find-the-culprit/28566113#28566113

