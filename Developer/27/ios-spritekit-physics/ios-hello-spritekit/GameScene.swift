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
  
  private let mm = CMMotionManager()
  private let g = 9.80  // Erdbeschleunigung
  private let colors:[SKColor] = [.red, .blue, .green, .yellow, .cyan]
  
  
  override func didMove(to view: SKView) {
    // Zufallszahlen initialisieren
    srand48(Int(arc4random_uniform (10000000)))
    
    // weißes Rechteck füllt Gerät aus
    let w = CGFloat(1000)
    let h = w / view.bounds.width * view.bounds.height
    self.size = CGSize(width: w, height: h)
    self.backgroundColor = .white
    self.scaleMode = .aspectFit
    
    // Objekte dort einsperren
    self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    
    // self.physicsBody!.usesPreciseCollisionDetection = true
    
    // Bälle
    setupBalls()
    
    // Motion Manager
    mm.deviceMotionUpdateInterval = 1.0 / 60
    mm.startDeviceMotionUpdates()
    
    // Speed
    self.physicsWorld.speed = 1
    
  }
  
  // Bälle erzeugen
  private func setupBalls() {
    for _ in 1...30 {
      // Ball mit zufälliger Position, Größe und Farbe
      let ball = SKSpriteNode(imageNamed: "ball")
      let r:CGFloat = 50 + cRnd() * 40
      ball.size = CGSize(width: 2*r, height: 2*r)
      ball.position = CGPoint(x: 150 + cRnd() * 700, y: 150 + cRnd() * 700)
      ball.zPosition = 1
      ball.color = colors[ iRnd(colors.count) ]
      ball.colorBlendFactor = 0.9
      self.addChild(ball)
      
      // physikalischen Körper dazu
      ball.physicsBody = SKPhysicsBody(circleOfRadius: r)
      // ball.physicsBody?.usesPreciseCollisionDetection = true
      // ball.physicsBody?.linearDamping = 1
      // ball.physicsBody?.angularDamping = 1
      ball.physicsBody?.restitution = 0.9
      ball.physicsBody?.allowsRotation = true
    }
  }
  
  // Gravitation gemäß der Neigung des Geräts
  override func update(_ currentTime: TimeInterval) {
    if let grav = mm.deviceMotion?.gravity {
      self.physicsWorld.gravity = CGVector(dx: grav.x * g, dy: grav.y * g)
    }
  }
  
  // Hilfsfunktionen
  private func cRnd() -> CGFloat { return CGFloat(drand48()) }
  private func iRnd(_ n:Int) -> Int {
    return Int(arc4random_uniform(UInt32(n)))
  }
}
