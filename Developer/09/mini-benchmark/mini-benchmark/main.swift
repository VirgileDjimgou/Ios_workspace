//
//  main.swift
//  mini-benchmark
//
//  Created by Michael Kofler on 13.09.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

// Hinweis: Das run-Schema erzeugt ein Release-Kompilat --
// schnell, aber ohne Debugging-Möglichkeiten.

import Foundation

print("start")
let start = Date()

var sum=0
for _ in 1...100_000_000 {
  sum +=  Int(arc4random_uniform(100))
}

let end = Date()
let seconds = end.timeIntervalSince(start)
print("fertig nach \(seconds) Sekunden")
