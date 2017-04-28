//
//  main.swift
//  hello-world-terminal
//
//  Created by Michael Kofler on 05.09.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import Foundation

print("Hello, World!")

func sayHello(name: String)  {
  print("Hello, \(name)!")
}

// den Namen des aktiven Nutzers ermitteln
var username = NSFullUserName()

// Funktion sayHello aufrufen
sayHello(name: username)


// Argumente auswerten, die an das Programm übergeben wurden
let args = CommandLine.arguments

print("Es wurden \(args.count-1) " +
  "Parameter übergeben.")

for i in 1..<args.count  {
  print("Parameter \(i): \(args[i])")
}



