//
//  GameScene.swift
//  ios-hello-spritekit
//
//  Created by Michael Kofler on 15.06.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene {
  
  private var spaceship: SKSpriteNode!
  private let mm = CMMotionManager()
  private var lasttime = Date()
  
  override func didMove(to view: SKView) {
    self.size = CGSize(width: 1024, height: 1024)
    self.backgroundColor = .gray
    self.scaleMode = .aspectFill
    
    
    let midPt = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
    spaceship = SKSpriteNode(imageNamed: "Spaceship")
    spaceship.position = midPt
    spaceship.zPosition = 1
    self.addChild(spaceship)
    
    mm.deviceMotionUpdateInterval = 1.0 / 60
    mm.startDeviceMotionUpdates()
    
  }
  // Raumschiff entsprechend des Yaw-Winkels drehen, dass
  // die Spitze immer nach oben zeigt
    override func update(_ currentTime: TimeInterval) {
      if let dm = mm.deviceMotion {
        spaceship.zRotation = -CGFloat(dm.attitude.yaw)
      }
    }
  
  //  // Raumschiff je nach Neigung des iPhones/iPads
  //  // nach links/rechts/vorne/hinten bewegen
  //  override func update(_ currentTime: TimeInterval) {
  //    if let dm = mm.deviceMotion {
  //      let deltax = CGFloat(dm.gravity.x) * 10
  //      let deltay = CGFloat(dm.gravity.y) * 10
  //      let pt = spaceship.position
  //      let newPt = CGPoint(x: pt.x + deltax, y: pt.y + deltay)
  //      spaceship.position = newPt
  //    }
  //  }
  
  
}
