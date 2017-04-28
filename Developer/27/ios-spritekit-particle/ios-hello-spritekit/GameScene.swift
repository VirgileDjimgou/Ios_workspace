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
  
  override func didMove(to view: SKView) {
    self.size = CGSize(width: 1024, height: 1024)
    self.backgroundColor = .black
    self.scaleMode = .aspectFill
    
    let spark = SKEmitterNode(fileNamed: "Spark")!
    spark.position = CGPoint(x: 500, y: 200)
    spark.zPosition = 1
    self.addChild(spark)
    
    let rain = SKEmitterNode(fileNamed: "Rain")!
    rain.position = CGPoint(x:500, y: 950)
    rain.zPosition = 1
    self.addChild(rain)
    
  }
  
  
  
  
  
  
}
