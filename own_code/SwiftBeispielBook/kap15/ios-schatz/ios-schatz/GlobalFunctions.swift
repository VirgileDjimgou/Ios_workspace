//
//  GlobalFunctions.swift
//  ios-schatz
//
//  Created by Michael Kofler on 20.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Foundation

// macht aus 12.5 --> "12° 30.00'"
func degreesMinutes(x:Double) -> String {
  let minutes = abs((x % 1) * 60)
  return String(format: "%d° %.2f'", Int(x), minutes)
}
