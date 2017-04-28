//
//  main.swift
//  memory
//
//  Created by Michael Kofler on 15.09.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import Foundation


class MyClass {
  var data: String
  init(data: String) {
    self.data = data
  }
  deinit {
    print("deinit")
  }
}

var a: MyClass? = MyClass(data: "abc")
var b: MyClass? = a
var c: MyClass? = a
b = nil
a = nil
c = nil
print("fertig")
// Ausgabe: zuerst 'deinit', dann 'fertig'

