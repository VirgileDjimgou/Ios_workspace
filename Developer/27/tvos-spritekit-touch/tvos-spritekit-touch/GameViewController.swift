//
//  GameViewController.swift
//  tvos-spritekit-touch
//
//  Created by Michael Kofler on 17.06.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let view = self.view as! SKView? {
      let scene = GameScene()
      scene.scaleMode = .aspectFill
      
      // Present the scene
      view.presentScene(scene)
      view.ignoresSiblingOrder = true
      view.showsFPS = true
      view.showsNodeCount = true
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Release any cached data, images, etc that aren't in use.
  }
}
