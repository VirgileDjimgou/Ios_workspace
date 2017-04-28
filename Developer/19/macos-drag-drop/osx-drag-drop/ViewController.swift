//
//  ViewController.swift
//  osx-drag-drop
//
//  Created by Michael Kofler on 28.04.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

  
  @IBOutlet weak var mv1: MyView!
  @IBOutlet weak var mv2: MyView!
  @IBOutlet weak var mv3: MyView!
  @IBOutlet weak var mvtrash: MyView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Was kann in die View gezogen werden?
    let dragtypes = [NSFilenamesPboardType, NSStringPboardType]
    mv1.register(forDraggedTypes: dragtypes)
    mv2.register(forDraggedTypes: dragtypes)
    mv3.register(forDraggedTypes: dragtypes)
    mvtrash.register(forDraggedTypes: [NSStringPboardType])
    
    // Welche Operationen werden als Quelle unterstützt
    mv1.dragSrcOp = [.copy, .move, .delete]
    mv2.dragSrcOp = [.copy, .move, .delete]
    mv3.dragSrcOp = [.copy, .move, .delete]
    mvtrash.dragSrcOp =  NSDragOperation()

    // Welche Operationen werden als Empfänger unterstützt
    mv1.dragDestOp = [.copy, .move]
    mv2.dragDestOp = [.copy, .move]
    mv3.dragDestOp = [.copy, .move]
    mvtrash.dragDestOp =  .delete
  }
}

