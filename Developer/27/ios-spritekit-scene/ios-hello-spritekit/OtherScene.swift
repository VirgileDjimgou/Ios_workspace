//
//  OtherScene.swift
//  ios-spritekit-scene
//
//  Created by Michael Kofler on 21.09.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import SpriteKit

class OtherScene : SKScene {
  override func didMove(to view: SKView) {

    for child in self.children {
      print(child)
    }

    
    let balloon = self.childNode(withName: "Balloon1") as! SKSpriteNode
    balloon.color = .red
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
  {
    if let myscene = MyScene(fileNamed: "MyScene") {
      myscene.scaleMode = .aspectFit
      let trans = SKTransition.fade(withDuration: 1)
      self.view?.presentScene(myscene, transition: trans)
    }
    
  }
  
}
