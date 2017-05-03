//
//  main.swift
//  hello-world-terminal
//
//  Created by Michael Kofler on 06.07.15.
//  Copyright © 2015 Michael Kofler. All rights reserved.
//

import Foundation

print("Hello, World!")

func sayHello(name: String)  {
  print("Hello, \(name)!")
}

// den Namen des aktiven Nutzers ermitteln
var username = NSFullUserName()

// Funktion sayHello aufrufen
sayHello(username)

// Zugriff auf Parameter, die an das Programm
// übergeben wurden
print("Es wurden \(Process.arguments.count-1) " +
  "Parameter übergeben.")

var cnt = 0;
for arg in Process.arguments {
  print("Parameter \(cnt): \(arg)")
  cnt+=1
}
