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
  private var fireNode:  SKShapeNode!
  
  override func didMove(to view: SKView) {
    self.size = CGSize(width: 1024, height: 1024)
    self.backgroundColor = .gray
    self.scaleMode = .aspectFill
    
    
    let midPt = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
    spaceship = SKSpriteNode(imageNamed: "Spaceship")
    spaceship.position = midPt
    spaceship.zPosition = 1
    self.addChild(spaceship)
    
    // roten Fire-Bereich
    fireNode = SKShapeNode(circleOfRadius: 50)
    fireNode.position = CGPoint(x: 750, y:300)
    fireNode.zPosition = 2
    fireNode.strokeColor = .red
    fireNode.lineWidth = 2
    fireNode.fillColor = .clear
    self.addChild(fireNode)
  }
  
  var lastPts = [CGPoint]()
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches {
      let pt =  t.location(in: self)
      if distance(pt1: pt, pt2: fireNode.position) < 50 {
          print("fire")
      } else {
        lastPts = [t.location(in: self)]
      }
    }
  }
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      lastPts.append(touch.location(in: self))
      // max. 20 Positionen speichern
      if lastPts.count>20 { lastPts.removeFirst() }
      if lastPts.count>5 {
        let startPt = lastPts.first!
        let pt = touch.location(in: self)
        let deltax = pt.x - startPt.x
        let deltay = pt.y - startPt.y
        spaceship.position = pt
        spaceship.zRotation = atan2(-deltax, deltay)
      }
    }
  }
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    // do nothing
  }
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    // do nothing
  }

  
  // Entfernung zwischen zwei Punkten ausrechnen
  private func distance(pt1: CGPoint, pt2: CGPoint) -> CGFloat {
    return sqrt((pt1.x-pt2.x)*(pt1.x-pt2.x) + (pt1.y-pt2.y)*(pt1.y-pt2.y))
  }
  
  //  // simplerer Variante ohne Fire-Knopf
  //
  //  var startPt: CGPoint!
  //
  //  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
  //    if let touch = touches.first {
  //      startPt = touch.location(in: self)
  //    }
  //  }
  //  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
  //    if let touch = touches.first {
  //      let startPt = touch.previousLocation(in: self)
  //      let pt = touch.location(in: self)
  //      let deltax = pt.x - startPt.x
  //      let deltay = pt.y - startPt.y
  //      spaceship.position = pt
  //      spaceship.zRotation = atan2(-deltax, deltay)
  //    }
  //  }
}
