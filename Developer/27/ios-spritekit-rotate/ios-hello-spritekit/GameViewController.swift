//
//  GameViewController.swift
//  ios-hello-spritekit
//
//  Created by Michael Kofler on 15.06.16.
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
      view.presentScene(scene)
      view.ignoresSiblingOrder = true  // Geschwindigkeitsoptimierung
      view.showsFPS = true             // FPS anzeigen
      view.showsNodeCount = true       // Anzahl der Nodes anzeigen
    }
  }
  
 }
