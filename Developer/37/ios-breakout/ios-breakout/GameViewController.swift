//
//  GameViewController.swift
//  ios-hello-sprite
//
//  Created by Michael Kofler on 21.05.16.
//  Copyright (c) 2016 Michael Kofler. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // drand48-Initialisierung
    srand48(Int(arc4random_uniform(100000000)))
    
    if let scene = GameScene(fileNamed:"GameScene") {
      // Configure the view.
      let skView = self.view as! SKView
      // skView.showsFPS = true
      // skView.showsNodeCount = true
      
      /* Sprite Kit applies additional optimizations to improve rendering performance */
      // skView.ignoresSiblingOrder = true
      
      /* Set the scale mode to scale to fit the window */
      scene.scaleMode = .aspectFill
      scene.size = CGSize(width: scene.size.width,
                          height: scene.size.width / skView.bounds.width * skView.bounds.height)
      
      skView.presentScene(scene)
            
      // skView.showsPhysics = true
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Release any cached data, images, etc that aren't in use.
  }
  
  // das bewirkt auch, dass man nicht versehentlich das Notification Center (oben)
  // bzw. das Control Center (unten) öffnet; möglich ist es aber weiterhin
  override var prefersStatusBarHidden: Bool {
    return true
  }
}
