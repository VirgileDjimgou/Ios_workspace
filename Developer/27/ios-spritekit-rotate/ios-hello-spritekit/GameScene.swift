//
//  GameScene.swift
//  ios-hello-spritekit
//
//  Created by Michael Kofler on 15.06.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
  
  private var spaceship: SKSpriteNode!
  private var angle:CGFloat = 0.0
  
  override func didMove(to view: SKView) {
    self.size = CGSize(width: 1024, height: 1024)
    self.backgroundColor = .gray
    self.scaleMode = .aspectFill

    
    let midPt = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
    spaceship = SKSpriteNode(imageNamed: "Spaceship")
    spaceship.position = midPt
    spaceship.zPosition = 1
    self.addChild(spaceship)
  }
  
  // wird 60 mal pro Sekunde aufgerufen
  // (sofern die volle Framerate möglich ist)
  override func update(_ currentTime: TimeInterval) {
    angle += .pi / 40.0
    let x0 = self.size.width / 2
    let y0 = self.size.height / 2
    let pos = CGPoint(x: x0 + 200 * cos(angle),
                      y: y0 + 200 * sin(angle))
    spaceship.position = pos
    spaceship.zRotation = angle
  }
  
}
