//
//  main.swift
//  indirect-enums
//
//  Created by Michael Kofler on 22.07.15.
//  Copyright © 2015 Michael Kofler. All rights reserved.
//

import Foundation


enum Tree {
  case Leaf(value:String)
  indirect case Node(Tree, Tree)
}

let mytree =
Tree.Node(
  Tree.Leaf(value: "a"),
  Tree.Node(
    Tree.Leaf(value: "b"), Tree.Leaf(value: "c")))

func showTree(t:Tree, indent n:Int = 0) {
  switch t {
  case .Leaf(let value):
    let indentation = String(count: n, repeatedValue: Character(" "))
    print(indentation + value)
  case .Node(let leaf1, let leaf2):
    showTree(leaf1, indent: n + 2)
    showTree(leaf2, indent: n + 2)
  }
}

showTree(mytree)


