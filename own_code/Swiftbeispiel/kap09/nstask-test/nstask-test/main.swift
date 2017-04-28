//
//  main.swift
//  nstask-test
//
//  Created by Michael Kofler on 22.07.15.
//  Copyright © 2015 Michael Kofler. All rights reserved.
//

import Foundation

// mit dem find-Kommando alle Dateien in /usr/bin suchen
let pipe = NSPipe()
let task = NSTask()
task.launchPath = "/usr/bin/find"
task.arguments = ["/usr/bin", "-type", "f"]
task.standardOutput = pipe
task.launch()

// Ergebnis von find zeilenweise ausgeben
let data = pipe.fileHandleForReading.readDataToEndOfFile()
if let nss = NSString(data: data,
  encoding: NSUTF8StringEncoding) {
    let s = String(nss)
    let lines = s.characters.split() {$0 == "\n"}.map { String($0) }
    for cmd in lines  {
      print(cmd)
    }
}