//
//  GameScene.swift
//  ios-hello-sprite
//
//  Created by Michael Kofler on 21.05.16.
//  Copyright (c) 2016 Michael Kofler. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
  // Objekte
  var paddle: SKShapeNode!
  var ball:   SKShapeNode!
  var label = SKLabelNode(fontNamed: "AvenirNext-Bold")
  
  var w:CGFloat = 0  // enthält Breite und Höhe des SKScene-Objekts
  var h:CGFloat = 0
  
  // Spielstatus
  var brickcounter = 0
  var status = GameStatus.waitForStart

  // Initialisierung
  override func didMove(to view: SKView) {
    w = self.frame.width
    h = self.frame.height
    
    // keine Gravitation
    self.physicsWorld.gravity = CGVector.zero
    
    // zur Erkennung, wann ein Ball einen Stein trifft
    self.physicsWorld.contactDelegate = self

    // Spielobjekte zusammenstellen
    setupBricks(rows: 6, cols: 6)
    setupPaddle()
    setupBall()
    setupText()
    
    // Ball einsperren
    self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    with(self.physicsBody!) {
      $0.categoryBitMask    = PhysCategory.frame
      $0.collisionBitMask   = PhysCategory.ball
      $0.contactTestBitMask = PhysCategory.none
    }
    
  }
  
  
  // Spielsteine einrichten
  func setupBricks(rows: Int, cols: Int) {
    let brickw = w / CGFloat(cols+1)
    let brickh = brickw / 3
    
    brickcounter = rows  * cols
    
    for row in 1...rows {
      let brickColor = SKColor.init(red: 0.7 + 0.3 * CGFloat(rows - row) / CGFloat(rows),
                                    green: 0.2,
                                    blue: 0,
                                    alpha: 1)
      for col in 1...cols {
        let brick = SKShapeNode(rectOf:
          CGSize(width: brickw * 0.95, height: brickh * 0.7))
        brick.fillColor   = brickColor
        brick.strokeColor = brickColor
        let x = brickw *  CGFloat(col)
        let y = h - brickh *  CGFloat(row+1)
        brick.position = CGPoint(x: x, y: y)
        brick.zPosition = 10
        brick.name = "brick"
        self.addChild(brick)
        brick.physicsBody = SKPhysicsBody(rectangleOf: brick.frame.size)
        with(brick.physicsBody!) {
          $0.isDynamic = false
          $0.categoryBitMask    = PhysCategory.brick
          $0.contactTestBitMask = PhysCategory.ball
          $0.collisionBitMask   = PhysCategory.ball
        }
        
      }
    }
  }
  
  func setupPaddle() {
    // Paddle unten positionieren, Breite ist 1/5 der Bildschirmbreite
    paddle = SKShapeNode(
      rectOf: CGSize(width: w * 0.20,
                     height: w * 0.04))
    paddle.fillColor   = SKColor.red
    paddle.strokeColor = SKColor.red
    paddle.position = CGPoint(x: w * 0.5,   // mittig
      y: h * 0.2)   // nicht ganz unten, damit besser bedienbar
    paddle.zPosition = 10
    self.addChild(paddle)
    paddle.physicsBody = SKPhysicsBody(rectangleOf: paddle.frame.size)
    with(paddle.physicsBody!) {
      $0.isDynamic = false
      $0.categoryBitMask    = PhysCategory.paddle
      $0.collisionBitMask   = PhysCategory.ball
      $0.contactTestBitMask = PhysCategory.none
    }
  }

  func setupBall() {
    // Ball in der Mitte oben
    ball = SKShapeNode(circleOfRadius: w/35)
    ball.fillColor = SKColor.black
    ball.strokeColor = SKColor.black
    ball.position = CGPoint(x: w * 0.25 + w * 0.5 * cRnd(), y: h*0.3)
    ball.zPosition = 10
    self.addChild(ball)
    
    // funktioniert nicht ordentlich, ergibt manchmal ganz flache Winkel
    // ball.physicsBody = SKPhysicsBody(circleOfRadius:  w/35)

    ball.physicsBody = SKPhysicsBody(rectangleOf: ball.frame.size)
    with(ball.physicsBody!) {
      $0.friction = 0
      $0.angularDamping = 0
      $0.linearDamping = 0
      $0.restitution = 1
      $0.allowsRotation = false
      $0.categoryBitMask    = PhysCategory.ball
      $0.contactTestBitMask = PhysCategory.brick
      $0.collisionBitMask   = PhysCategory.brick +
                              PhysCategory.paddle +
                              PhysCategory.frame
    }
    

  }
  
  func initialImpulse() -> CGVector {
    return CGVector(dx: w * 0.05, dy: w * 0.05)
  }
  
  func setupText() {
    // Label für Start / Game over / Gratulation!
    label.position = CGPoint(x: w/2, y: h/2)
    label.zPosition = 100
    label.fontSize = 50
    label.text = "Tap to start game"
    self.addChild(label)
  }
  
  
  // MARK: Spielsteuerung
  // Status-Wechsel durch Tap
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if status == .waitForStart {
      
      // erstes Spiel: Ball in Bewegung setzen
      ball.physicsBody!.applyImpulse(initialImpulse())
      status = .running
      label.text = ""
    } else if status == .won || status == .lost {
      
      // neues Spiel starten: zuerst aufräumen
      ball.removeFromParent()
      for ch in self.children {
        if let childname = ch.name, childname == "brick" {
          ch.removeFromParent()
        }
      }
      
      // dann Spielfeld neu einrichten
      setupBall()
      setupBricks(rows:6, cols:6)
      ball.physicsBody!.applyImpulse(initialImpulse())
      status = .running
      label.text = ""
      self.isPaused = false
    }
    
  }
  
  // Paddle-Steuerung durch Finger
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if touches.count != 1 { return }
    let touch = touches.first!
    let xnew = touch.location(in: self).x
    let xmin = paddle.frame.size.width/2
    let xmax = self.frame.size.width - xmin
    paddle.position =
      CGPoint(x: minMax(xnew, minimum: xmin, maximum: xmax),
              y: paddle.position.y)
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    // no code
  }
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    // no code
  }
  
  // Spielende feststellen
  override func update(_ currentTime: TimeInterval) {
    if status != .running { return }
    
    // Test, ob Spiel verloren ist
    if ball.position.y  < paddle.frame.minPoint().y {
      label.text = "Game Over"
      self.isPaused = true
      status = .lost
      return
    }
    
    // manchmal passiert es, dass der Ball sich nur noch horizontal oder vertikal
    // bewegt; dann muss man eben nachhelfen
    if abs(ball.physicsBody!.velocity.dx) <= 0.01 ||
       abs(ball.physicsBody!.velocity.dy) <= 0.01
    {
      print(ball.physicsBody!.velocity)
      ball.physicsBody!.velocity = CGVector.zero
      ball.physicsBody!.applyImpulse(initialImpulse())
    }
  }
}

// MARK: Kollisionserkennung
// zur Erkennung, wann ein Stein vom Ball getroffen wird
extension GameScene : SKPhysicsContactDelegate {

  func didBegin(_ contact: SKPhysicsContact) {
    var brick:SKNode!
    if contact.bodyA.categoryBitMask == PhysCategory.brick {
      brick = contact.bodyA.node
    } else if contact.bodyB.categoryBitMask == PhysCategory.brick {
      brick = contact.bodyB.node
    } else {
      return
    }
    
    // Stein entfernen
    brick.removeFromParent()
    
    // Spielende?
    brickcounter -= 1
    if brickcounter == 0 {
      self.isPaused = true
      label.text = "Congratulations!"
      status = .won
    }
  }
}

// MARK: Sonstiges
struct PhysCategory {
  static let none:UInt32   = 0
  static let ball:UInt32   = 1
  static let paddle:UInt32 = 2
  static let brick:UInt32  = 4
  static let frame:UInt32  = 8
}

enum GameStatus {
  case waitForStart, running, won, lost
}

func with<T>(_ object: T, closure: (T)->()) {
  closure(object)
}

