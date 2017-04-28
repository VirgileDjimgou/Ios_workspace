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
  private var pacman: SKSpriteNode!
  
  override func didMove(to view: SKView) {
    self.size = CGSize(width: 1024, height: 1024)
    self.backgroundColor = .gray
    self.scaleMode = .aspectFill

    // Raumschiff einrichten und durch Actions animieren
    let midPt = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
    spaceship = SKSpriteNode(imageNamed: "Spaceship")
    spaceship.position = midPt
    spaceship.zPosition = 1
    self.addChild(spaceship)
    spaceshipAction()

    // Pacman einrichten
    pacman = SKSpriteNode(imageNamed: "player-0")
    pacman.position = CGPoint(x: 400, y: 350)
    pacman.zPosition = 2
    self.addChild(pacman)
    pacmanAction()
    
  }
 
  // Raumschiff mit diversen Aktionen steuern
  func spaceshipAction() {
    let pt = CGPoint(x: 512, y: 800)
    let m = SKAction.move(to: pt, duration: 1)
    let r1 = SKAction.rotate(byAngle: .pi/4, duration: 1)
    let w = SKAction.wait(forDuration: 1)
    let sc = SKAction.scale(by: 0.7, duration: 1)
    let rv = sc.reversed()
    let c1 = SKAction.colorize(with: .red, colorBlendFactor: 1, duration: 1)
    let c2 = SKAction.colorize(withColorBlendFactor: 0, duration: 1)
    let r2 = SKAction.rotate(toAngle: 0, duration: 1, shortestUnitArc: true)
    let fo = SKAction.fadeOut(withDuration: 1)
    let rm = SKAction.removeFromParent()
    let my = SKAction.run( {
      print("done")
    })
    // hintereinander ausführen
    let s = SKAction.sequence([m, r1, sc, rv, c1, c2, w, r2, fo, rm, my])
    spaceship.run(s)
  }
 
  // PacMan animieren
  func pacmanAction() {
    var frames = [SKTexture]()
    for i in [0, 1, 2, 3, 4, 5, 6, 7, 6, 5, 4, 3, 2, 1] {
      let texture = SKTexture(imageNamed: "player-\(i)")
      frames.append(texture)
    }
    let animate = SKAction.animate(with: frames, timePerFrame: 0.05)
    let forever = SKAction.repeatForever(animate)
    pacman.run(forever)
  }
  
  
  
}
