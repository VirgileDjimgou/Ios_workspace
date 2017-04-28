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
  private var angle: CGFloat = 0.0
  
  override func didMove(to view: SKView) {
    self.size = CGSize(width: 1024, height: 1024)
    self.backgroundColor = .gray
    self.scaleMode = .aspectFill

    
    let midPt = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
    spaceship = SKSpriteNode(imageNamed: "Spaceship")
    spaceship.position = midPt
    spaceship.zPosition = 1
    self.addChild(spaceship)
    
    // Sprite-Aussehen verändern
    // manipulate(sprite: spaceship)
    
    // Sprites ohne Bitmap erzeugen
    // createShapes()
    
    // Schrift erzeugen
    // createLabel()
  }
  
  
  
  
  
  
  
  
  // Sprite-Aussehen verändern
  private func manipulate(sprite: SKSpriteNode) {
    sprite.anchorPoint = CGPoint(x: 0, y: 0)
    sprite.zRotation = .pi/8
    sprite.alpha = 0.5
    sprite.color = .red
    sprite.colorBlendFactor = 2.0
    sprite.size = CGSize(width: 500, height: 500)
  }
  
  // Shapes sind quasi Sprites ohne Bitmaps
  private func createShapes() {
    let shape1 = SKShapeNode(circleOfRadius: 50)
    shape1.fillColor = .green
    shape1.strokeColor = .red
    shape1.lineWidth = 5
    shape1.position = CGPoint(x: 500, y: 500)
    shape1.zPosition = 2
    self.addChild(shape1)
    
    let rect = CGRect(x: 400, y: 600, width: 100, height: 30)
    let shape2 = SKShapeNode(rect: rect, cornerRadius: 10)
    shape2.fillColor = .blue
    shape2.strokeColor = .blue
    shape2.zPosition = 3
    self.addChild(shape2)
  }
  
  // Textfeld erzeugen
  private func createLabel() {
    let label = SKLabelNode(fontNamed: "AvenirNext-Bold")
    label.text = "Game Over"
    label.fontColor = .blue
    label.fontSize = 70
    let midPt = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
    label.position = midPt
    label.zPosition = 4
    label.verticalAlignmentMode = .center
    self.addChild(label)
  }
  
  // die update-Methode wird nach Möglichkeit 
  // 60 mal pro Sekunde aufgerufen

  // Kommentare entfernen, dann dreht sich das Raumschiff
  // um den Mittelpunkt ...
  
  //  override func update(_ currentTime: TimeInterval) {
  //    angle += .pi / 40.0
  //    // Mittelpunkt, um den das Raumschiff kreist
  //    let x0 = self.size.width / 2
  //    let y0 = self.size.height / 2
  //    // Kreisradius 200
  //    let pos = CGPoint(x: x0 + 200 * cos(angle),
  //                      y: y0 + 200 * sin(angle))
  //    spaceship.position = pos
  //    spaceship.zRotation = angle
  //  }

  
  

  // nur für Screenshot
  // mit Bitmap- und Farbliteralen
  func test1() {
    spaceship = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "Spaceship")))
    spaceship.color = #colorLiteral(red: 0.1431525946, green: 0.4145618975, blue: 0.7041897774, alpha: 1)
  }
  
  // herkömmlicher Code
  func test2() {
    spaceship = SKSpriteNode(imageNamed: "Spaceship")
    spaceship.color = .blue
  }
  

}
