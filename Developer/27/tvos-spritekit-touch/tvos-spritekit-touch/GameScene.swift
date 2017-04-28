//
//  GameScene.swift
//  tvos-spritekit-touch
//
//  Created by Michael Kofler on 17.06.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
  private var spaceship: SKSpriteNode!
  var lastPts = [CGPoint]()
  
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
  
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      lastPts = [touch.location(in: self)]
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let t = touches.first {
      // max. 20 Positionen speichern
      lastPts.append(t.location(in: self))
      if lastPts.count>20 { lastPts.removeFirst() }

      // Position ändern
      let deltax = t.location(in: self).x - t.previousLocation(in: self).x
      let deltay = t.location(in: self).y - t.previousLocation(in: self).y
      let current = spaceship.position
      spaceship.position =
        CGPoint(x: current.x + deltax, y: current.y + deltay)
      
      // Richtung nur ändern, wenn zumindest fünf Touch-Ereignisse
      if lastPts.count>5 {
        let startPt = lastPts.first!
        let deltax = current.x - startPt.x
        let deltay = current.y - startPt.y
        spaceship.zRotation = atan2(-deltax, deltay)
      }

    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    
  }
  
  
}
