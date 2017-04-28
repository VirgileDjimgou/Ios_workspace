//
//  Globals.swift
//  ios-compass
//
//  Created by Michael Kofler on 25.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//



func with<T>(_ object: T, closure: (T)->()) {
  closure(object)
}
