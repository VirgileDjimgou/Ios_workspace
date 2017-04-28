//
//  MyScene.swift
//  ios-spritekit-scene
//
//  Created by Michael Kofler on 28.06.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import SpriteKit

class MyScene: SKScene {
  override func didMove(to view: SKView) {
    
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
  {
    if let other = OtherScene(fileNamed: "OtherScene") {
      other.scaleMode = .aspectFill
      let trans = SKTransition.fade(withDuration: 1)
      self.view?.presentScene(other, transition: trans)
    }
    
  }
}
