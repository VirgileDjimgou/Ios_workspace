//
//  main.swift
//  weak-references
//
//  Created by Michael Kofler on 08.07.15.
//  Copyright © 2015 Michael Kofler. All rights reserved.
//

import Foundation

// drei Klassen mit strong-Referenzen aufeinander
class Class1a {
  var pointsTo2:Class2a?
  
  deinit {
    print("deinit Class 1a")
  }
}

class Class2a {
  var pointsTo3:Class3a?
  
  deinit {
    print("deinit Class 2a")
  }
}

class Class3a {
  var pointsTo1:Class1a?
  
  deinit {
    print("deinit Class 3a")
  }
}

// drei Klassen mit weak-Referenzen aufeinander
class Class1b {
  weak var pointsTo2:Class2b?
  
  deinit {
    print("deinit Class 1b")
  }
}

class Class2b {
  weak var pointsTo3:Class3b?
  
  deinit {
    print("deinit Class 2b")
  }
}

class Class3b {
  weak var pointsTo1:Class1b?
  
  deinit {
    print("deinit Class 3b")
  }
}



if true {
  var c1a = Class1a()
  var c2a = Class2a()
  var c3a = Class3a()
  c1a.pointsTo2 = c2a
  c2a.pointsTo3 = c3a
  c3a.pointsTo1 = c1a
  
  var c1b = Class1b()
  var c2b = Class2b()
  var c3b = Class3b()
  c1b.pointsTo2 = c2b
  c2b.pointsTo3 = c3b
  c3b.pointsTo1 = c1b
  
  print("if-Block endet")
}

// ab hier werden c1a, c1b, c2a, c2b,
// c3a und c3b nicht mehr benötigt; wegen
// der zyklichen Verweise kommt es aber
// nur bei c1b, c2b und c3b zum deinit-Aufruf
print("nach dem if-Block")


