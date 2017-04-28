//
//  main.swift
//  indirect-enums
//
//  Created by Michael Kofler on 22.07.15.
//  Copyright © 2015 Michael Kofler. All rights reserved.
//

import Foundation


indirect enum Tree {
  case leaf(value: String)
  case node(Tree, Tree)
}

let mytree =
  Tree.node(
    Tree.leaf(value: "a"),
    Tree.node(Tree.leaf(value: "b"),
              Tree.leaf(value: "c")))

func showTree(_ t: Tree, indent n: Int = 0) {
  switch t {
  case .leaf(let value):
    let indentation = String(repeating: " ", count: n)
    print(indentation + value)
  case .node(let leaf1, let leaf2):
    showTree(leaf1, indent: n + 2)
    showTree(leaf2, indent: n + 2)
  }
}

showTree(mytree)

enum genericTree<T> {
  case leaf(value: T)
  indirect case node(genericTree, genericTree)
}


