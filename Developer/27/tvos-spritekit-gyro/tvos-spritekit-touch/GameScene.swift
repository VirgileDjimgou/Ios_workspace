//
//  GameScene.swift
//  tvos-spritekit-touch
//
//  Created by Michael Kofler on 17.06.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import SpriteKit
import GameController

class GameScene: SKScene {
  private var spaceship: SKSpriteNode!
  
  // Raumschiff in der Mitte der Szene platzieren
  override func didMove(to view: SKView) {
    self.size = CGSize(width: 1920, height: 1080)
    self.backgroundColor = .gray
    self.scaleMode = .aspectFill
    
    let midPt = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
    spaceship = SKSpriteNode(imageNamed: "Spaceship")
    spaceship.position = midPt
    spaceship.zPosition = 1
    self.addChild(spaceship)
  }
  
  override func update(_ currentTime: TimeInterval) {
    if let motion = GCController.controllers().first?.motion {
      let deltax = CGFloat(motion.gravity.x) * 10
      let deltay = -CGFloat(motion.gravity.y) * 25
      let pt = spaceship.position
      let newPt = CGPoint(x: pt.x + deltax, y: pt.y + deltay)
      spaceship.position = newPt
    }
  }
  
  
}
