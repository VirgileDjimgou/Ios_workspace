//
//  main.swift
//  defer-test
//
//  Created by Michael Kofler on 21.07.15.
//  Copyright © 2015 Michael Kofler. All rights reserved.
//

import Foundation

enum MyErrors : ErrorType {
  case Test
}

func test() throws {
  print("open f1")
  defer { print("close f1") }
  if arc4random_uniform(100) > 90 { return }
  
  print("open f2")
  defer { print("close f2") }
  
  print("read from f1")
  if arc4random_uniform(100) > 90 { throw MyErrors.Test }
  print("write to f2")
}

// kann einen Fehler auslösen, das ist beabsichtigt
try! test()
