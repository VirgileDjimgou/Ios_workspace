//
//  GameViewController.swift
//  tvos-spritekit-getfocus
//
//  Created by Michael Kofler on 22.09.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
  
  var myscene: SKScene!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let view = self.view as! SKView? {
      myscene = GameScene(
        size: CGSize(width: 1920, height: 1080))
      myscene.scaleMode = .aspectFill
      view.presentScene(myscene)
      //      view.ignoresSiblingOrder = true
      //      view.showsFPS = true
      //      view.showsNodeCount = true
    }
  }
  
  override var preferredFocusEnvironments: [UIFocusEnvironment] {
    if myscene != nil {
      // print("preferred: myscene")
      return [myscene]
    } else {
      return []
    }
  }


}
