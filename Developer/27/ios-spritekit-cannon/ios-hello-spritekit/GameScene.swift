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
  let w:CGFloat = 1000   // Größe des Spielfelds
  var h:CGFloat = 0      // wird in didMove eingestellt
  
  let bx:CGFloat = 250   // Ort der Kugel
  let by:CGFloat = 275
  let br:CGFloat = 25    // Radius der Kugel
  var aiming = false     // aktiver Zielvorgang
  
  let fx:CGFloat = 800   // Ecke rechts oben des
  let fy:CGFloat = 250   // Bodens (Floor)
  
  let brickRows = 9        // Pyramidenhöhe
  let brickW:CGFloat = 40  // Größe der Ziegelsteine
  let brickH:CGFloat = 28
  
  // Kanonenkugel + Ring rundherum; die Objekte werden
  // in setupBall endgültig eingerichtet
  let ball = SKSpriteNode(imageNamed: "cannon-ball")
  var ring = SKShapeNode(circleOfRadius: 0)
  
  override func didMove(to view: SKView) {
    srand48(Int(arc4random_uniform (10000000)))
    
    h = w / view.bounds.width * view.bounds.height
    self.size = CGSize(width: w, height: h)
    self.backgroundColor = SKColor(white: 0.9, alpha: 1)
    self.scaleMode = .aspectFit
    
    setupFloor()
    setupPyramid()
    setupBall()
    
    // alle Objekte im Bildschirm einsperren
    self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
  }
  
  private func setupFloor() {
    let x0 = fx - brickW * (CGFloat(brickRows) + 0.5)
    let x1 = fx
    let y0 = fy - 30
    let y1 = fy
    let floor = SKShapeNode(rect: CGRect(x: x0, y: y0, width: x1 - x0, height: y1 - y0))
    floor.fillColor = .black
    floor.lineWidth = 0
    self.addChild(floor)
    floor.physicsBody = SKPhysicsBody(edgeLoopFrom: floor.frame)

    let path = UIBezierPath()
    path.move(to:    CGPoint(x: w,     y: fy))
    path.addLine(to: CGPoint(x: w-100, y:0))
    path.addLine(to: CGPoint(x: w,     y:0))
    path.close()

    // Rutsche für Ziegel
    let triangle = SKShapeNode(path: path.cgPath)
    triangle.fillColor = .black
    triangle.lineWidth = 0
    self.addChild(triangle)
    triangle.physicsBody = SKPhysicsBody(polygonFrom: path.cgPath)
  }
  
  // Pyramide bauen
  private func setupPyramid() {
    let xstart = fx - brickW * CGFloat(brickRows)
    var i = brickRows
    while(i>0) {
      setupLineOfBricks(x0: xstart + (brickW / 2 * CGFloat(brickRows - i)),
                        y0: fy + brickH / 2 + CGFloat(brickRows - i) * brickH,
                        n: i)
      i-=1
    }
  }
  private func setupLineOfBricks(x0: CGFloat, y0: CGFloat, n: Int) {
    for i in 0...n-1 {
      let brickcolor = SKColor(red: 0.6 + 0.2 * cRnd(),
                               green: 0.3 + 0.2 * cRnd(),
                               blue: 0.1 + 0.1 * cRnd(),
                               alpha: 1)
      let brick = SKSpriteNode(imageNamed: "brick")
      brick.size = CGSize(width: brickW, height: brickH)
      brick.color = brickcolor
      brick.colorBlendFactor = 0.5
      brick.position = CGPoint(x: x0 + CGFloat(i) * (brickW + 3), y: y0)
      brick.zPosition = 1
      self.addChild(brick)
      brick.physicsBody = SKPhysicsBody(rectangleOf: brick.frame.size)
      brick.physicsBody?.friction = 0.9
      brick.physicsBody?.restitution = 0.05
      brick.physicsBody?.categoryBitMask = Category.brick
      brick.physicsBody?.collisionBitMask = Category.ball + Category.brick
      
    }
  }
  
  // Kanonenkugel einrichten
  private func setupBall() {
    ball.size = CGSize(width: 2*br, height: 2*br)
    ball.position = CGPoint(x: bx, y: by)
    ball.zPosition = 2
    self.addChild(ball)
    ball.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(br))
    ball.physicsBody?.affectedByGravity = false
    // werden erst korrekt eingestellt, wenn der Ball
    // losgelassen wird
    ball.physicsBody?.categoryBitMask = Category.none
    ball.physicsBody?.collisionBitMask = Category.none
    ball.physicsBody?.density = 3
    ball.physicsBody?.restitution = 0.1
    
    // roter Kreis rund um Ball
    ring = SKShapeNode(circleOfRadius: CGFloat(br * 1.5))
    ring.position = CGPoint(x: bx, y: by)
    ring.fillColor = .clear
    ring.lineWidth = 4
    ring.strokeColor = .red
    ring.zPosition = 1
    self.addChild(ring)
  }
  
  // Kanonenkugel los schießen
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if touches.count != 1 { return }
    if ball.position.distanceTo(ring.position) > 1 { return }
    let touch = touches.first!
    let pt = touch.location(in: self)
    if pt.distanceTo(ring.position) < br * 1.5 {
      aiming = true
    }
  }

  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if aiming == false    { return }
    if touches.count != 1 { return}
    let touch = touches.first!
    let pt = touch.location(in: self)
    
    // Ball verschieben: 2/3 auf der Strecke Ball / Finger
    ball.position = (pt * 2 + ring.position) / 3
    
    // roten Kreis verkleinern
    ring.fillColor = .red
    let scale = max(0.2, (300 - pt.distanceTo(ring.position)) / 300)
    ring.setScale(scale)
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    if aiming == false    { return }
    if touches.count != 1 { return}
    let touch = touches.first!
    let pt = touch.location(in: self)

    // Impuls auf Ball ausrechnen, umso stärker
    // je weiter weg vom Startpunkt
    let vec = (ring.position - pt) * 2
    let imp = CGVector(dx: vec.x, dy: vec.y)
    ball.physicsBody?.applyImpulse(imp)
    
    // Schwerkraft und Kollisions-Handling einschalten
    ball.physicsBody?.affectedByGravity = true
    ball.physicsBody?.categoryBitMask = Category.ball
    ball.physicsBody?.collisionBitMask = Category.brick
    
    // Ball nach drei Sekunden zurück in den Ring
    let wait = SKAction.wait(forDuration: 3)
    let run = SKAction.run() {
      self.ball.physicsBody?.affectedByGravity = false
      self.ball.physicsBody?.isResting = true
      self.ball.physicsBody?.categoryBitMask = Category.none
      self.ball.physicsBody?.collisionBitMask = Category.none
      self.ball.position = self.ring.position
    }
    ball.run( .sequence([wait, run]))
    
    // Zielring wieder normal darstellen
    ring.setScale(1)
    ring.fillColor = .clear
    aiming = false
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    // Ball zurück an die Ausgangsposition
    ball.position = CGPoint(x: bx, y: by)
    // Zielring wieder normal darstellen
    ring.setScale(1)
    ring.fillColor = .clear
    aiming = false
  }
  
  
  // Kategories
  struct Category {
    static let none:UInt32  = 0
    static let ball:UInt32  = 1
    static let brick:UInt32 = 2
  }
  
  // Zufallszahlen
  private func cRnd() -> CGFloat { return CGFloat(drand48()) }
  private func iRnd(_ n:Int) -> Int {
    return Int(arc4random_uniform(UInt32(n)))
  }
  
}
