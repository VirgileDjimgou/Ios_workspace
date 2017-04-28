//
//  main.swift
//  access-level
//
//  Created by Michael Kofler on 14.09.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import Foundation

print("Hello, World!")

open class MyClass1 {
  
}

public class MyClass2 {
  
}

internal class MyClass3 {
  
}

fileprivate class MyClass4 {
  
}

private class MyClass5 : MyClass4 {
  
}

// Testcode
let o1 = MyClass1()
let o2 = MyClass2()
let o3 = MyClass3()
fileprivate let o4 = MyClass4()
private let o5 = MyClass5()

