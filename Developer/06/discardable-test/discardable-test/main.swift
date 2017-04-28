//
//  main.swift
//  discardable-test
//
//  Created by Michael Kofler on 18.09.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import Foundation

func f() -> Int {
  return 42
}

@discardableResult func g() -> Int {
  return 43
}

// f()   // Warnung: Result of call f() is unused
_ = f()  // OK
g()      // OK wegen @discardableResult
