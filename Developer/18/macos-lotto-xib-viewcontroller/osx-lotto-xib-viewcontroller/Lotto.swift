//
//  Lotto.swift
//  osx-lotto-xib-windowcontroller
//
//  Created by Michael Kofler on 02.05.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Foundation

class Lotto {
  let count:Int
  let max:UInt32
  
  init(count:Int, max:Int) {
    self.count = count
    self.max     = UInt32(max)
  }
  
  func generateNumbers() -> [Int] {
    var set = Set<Int>()        // leeres Set erzeugen
    repeat {                        // Lottozahlen einfügen
      set.insert(Int(arc4random_uniform(max))+1)
    } while(set.count < count)
    
    let lotto = Array(set)
    return lotto.sorted(by: <)                // sortieren
  }
}
