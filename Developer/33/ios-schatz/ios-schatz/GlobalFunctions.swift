//
//  GlobalFunctions.swift
//  ios-schatz
//
//  Created by Michael Kofler on 20.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Foundation

// macht aus 12.5 --> "12° 30.00'"
func degreesMinutes(_ x:Double) -> String {
  // früher funktionierte remainder = x % 1
  let remainder = x.truncatingRemainder(dividingBy: 1)
  // abs, weil das Vorzeichen schon bei den Grad angezeigt wird
  // kein zweites Vorzeichen bei den Minuten erforderlich
  let minutes = abs(remainder * 60)
  return String(format: "%d° %.2f'", Int(x), minutes)
}

//func testDegrees() {
//  print(degreesMinutes(12.5))
//  print(degreesMinutes(12.1))
//  print(degreesMinutes(-12.1))
//}
