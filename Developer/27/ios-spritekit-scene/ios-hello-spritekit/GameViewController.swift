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

  // wird beim Start der App ausgeführt
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let view = self.view as! SKView? {
      let myScene = MyScene(fileNamed: "MyScene")
      myScene?.scaleMode = .aspectFit
      view.presentScene(myScene)

      view.ignoresSiblingOrder = true  // Geschwindigkeitsoptimierung
      view.showsFPS = true             // FPS anzeigen
      view.showsNodeCount = true       // Anzahl der Nodes anzeigen
    }
  }
  
  
  override var shouldAutorotate: Bool {
    return true
  }
  override var prefersStatusBarHidden: Bool {
    return true
  }
  override var supportedInterfaceOrientations:
    UIInterfaceOrientationMask
  {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return .allButUpsideDown
    } else {
      return .all
    }
  }
  
}
