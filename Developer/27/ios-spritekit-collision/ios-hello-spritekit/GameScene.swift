import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
  
  private let w:CGFloat = 2000
  private var h:CGFloat = 0
  private var timeLastBalloon = Date()
  private var arrows = [SKSpriteNode]()
  private var gameOver = false
  
  
  override func didMove(to view: SKView) {
    // Zufallszahlen initialisieren
    initRnd()
    
    // Hintergrundbild einrichten
    h = w / view.bounds.width * view.bounds.height
    self.size = CGSize(width: w, height: h)
    let backg = SKSpriteNode(imageNamed: "wiese-himmel")
    backg.position = CGPoint(x: w / 2, y: h / 2)
    backg.zPosition = 0
    self.addChild(backg)
    
    // Kollisionserkennung
    self.physicsWorld.contactDelegate = self
    self.physicsWorld.gravity = CGVector.zero
    
    setupArrows()
  }
  
  // 10 Pfeile am unteren Bildschirmrand positionieren
  func setupArrows() {
    for i in 0...9 {
      let arrow = SKSpriteNode(imageNamed: "pfeil")
      arrow.setScale(0.7)
      let x = w / 11 * (CGFloat(i) + 1)
      let y = arrow.size.height/2
      
      arrow.position = CGPoint(x: x, y: y)
      arrow.zPosition = 20
      arrow.color = .red
      arrow.colorBlendFactor = 1
      self.addChild(arrow)
      arrows.append(arrow)
      
      // ganzer Pfeil ist Kollisionsfläche
      arrow.physicsBody = SKPhysicsBody(texture: arrow.texture!, size: arrow.size)
      
      // nur die Spitze des Pfeils bei der Kollision berücksichtigen
      //      let ptX:CGFloat = 0
      //      let ptY:CGFloat = arrow.frame.size.height / 2.0 - 5.0
      //      arrow.physicsBody = SKPhysicsBody(circleOfRadius: 5,
      //                                        center: CGPoint(x: ptX, y: ptY))
      
      // Masken für die Kollisionserkennung
      arrow.physicsBody?.categoryBitMask    = Category.arrow
      arrow.physicsBody?.contactTestBitMask = Category.balloon
      arrow.physicsBody?.collisionBitMask   = Category.none
    }
  }
  
  // regelmäßig Ballone starten
  override func update(_ currentTime: TimeInterval) {
    if !gameOver && Date() > timeLastBalloon.addingTimeInterval(1) {
      startNewBalloon()
      timeLastBalloon = Date()
    }
  }
  
  private func startNewBalloon() {
    // neuer Luftballon mit zufälliger Farbe
    let balloon = SKSpriteNode(imageNamed: "luftballon")
    balloon.color = bColors[ iRnd(bColors.count) ]
    balloon.colorBlendFactor = 0.5 + 0.25 * cRnd()
    
    // Startposition
    let fromLeft =  cRnd() > 0.5
    let xStart:CGFloat = fromLeft ? -100 : w + 100
    let yStart:CGFloat = h / 3 + h / 3 * cRnd()
    balloon.position = CGPoint(x: xStart, y: yStart)
    balloon.zPosition = 2 + cRnd() * 10
    
    // Größe
    let bWidth = 140 + cRnd() * 40
    let bHeight = bWidth * (1.1 + 0.2 * cRnd())
    balloon.size = CGSize(width: bWidth, height: bHeight)
    self.addChild(balloon)
    
    // Körper
    // balloon.physicsBody = SKPhysicsBody(circleOfRadius: bWidth/2)
    balloon.physicsBody =
      SKPhysicsBody(texture: balloon.texture!,
                    size: balloon.size)
    balloon.physicsBody?.categoryBitMask    = Category.balloon
    balloon.physicsBody?.contactTestBitMask = Category.arrow
    balloon.physicsBody?.collisionBitMask   = Category.none
    
    
    // Bewegung quer über den Bildschirm, leicht aufwärts
    let xEnd:CGFloat = fromLeft ?  w + 100 : -100
    let yEnd:CGFloat = yStart + w/2 * cRnd()
    let targetPt = CGPoint(x: xEnd, y: yEnd)
    let mv = SKAction.move(to: targetPt, duration: 5 + 3 * dRnd())
    
    // gleichzeitig Luftballon leicht hin- und herdrehen
    let r1 = SKAction.rotate(byAngle: .pi/10, duration: 0.5)
    let r2 = SKAction.rotate(byAngle: -.pi/5, duration: 1)
    let r3 = SKAction.rotate(byAngle: .pi/10, duration: 0.5)
    let wiggle = SKAction.sequence([r1,r2,r3])
    let wiggle4 = SKAction.repeat(wiggle, count: 4)
    let mvAndWiggle = SKAction.group([wiggle4, mv])
    
    // zum Schluss löschen
    let del = SKAction.removeFromParent()
    balloon.run( .sequence( [mvAndWiggle, del] ))
  }
  
  // Pfeile bei Berührung nach oben abschießen
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if gameOver {
      // Neustart
      setupArrows()
      gameOver = false
    } else {
      for t in touches { startArrow(touch: t) }
    }
    
  }
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    // for t in touches { startArrow(touch: t) }
  }
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    // kein Code
  }
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    // kein Code
  }
  private func startArrow(touch: UITouch) {
    let pos = touch.previousLocation(in: self)
    // für alle Pfeile testen, ob sie angeklickt wurden
    for a in arrows {
      if a.frame.contains(pos) {
        let target = CGPoint(x: a.position.x, y: h + a.size.height)
        let mv = SKAction.move(to: target, duration: 1)
        let del = SKAction.removeFromParent()
        let tst = SKAction.run() {
          self.gameOver = (self.arrows.count == 0)
        }
        a.run( SKAction.sequence([mv, del, tst]) )
        arrows.remove(at: arrows.index(of: a)!)
        break  // Schleife beenden
      }
    }
  }
  
  
  
  // wird bei jeder Kollision aufgerufen
  func didBegin(_ contact: SKPhysicsContact) {
    if let balloon = getSpriteFrom(contact, category: Category.balloon) {
      // keine weiteren Berührungen melden
      balloon.physicsBody?.contactTestBitMask = Category.none
      let shrink = SKAction.scale(to: 0, duration: 0.3)
      let del = SKAction.removeFromParent()
      balloon.run( .sequence([shrink, del]))
    }
    
  }
  
  
  // MARK: sonstiges
  // Zufallszahlen für diverse Zahlentypen
  private func cRnd() -> CGFloat {
    return CGFloat(drand48())
  }
  private func dRnd() -> Double {
    return drand48()
  }
  private func iRnd(_ n:Int) -> Int {
    return Int(arc4random_uniform(UInt32(n)))
  }
  private func initRnd() {  // initalisieren
    srand48(Int(arc4random_uniform(100000000)))
  }

  
  
  // Farben der Luftballone
  let bColors:[SKColor] = [.red, .blue, .green, .yellow, .cyan]
  
  // Objekt-Kategorien für die Kollisionserkennung
  struct Category {
    static let none:UInt32    = 0
    static let balloon:UInt32 = 1
    static let arrow:UInt32   = 2
  }

  
  func getSpriteFrom(_ contact: SKPhysicsContact, category: UInt32) -> SKSpriteNode?
  {
    if contact.bodyA.categoryBitMask == category {
      return contact.bodyA.node as? SKSpriteNode
    } else if contact.bodyB.categoryBitMask == category {
      return  contact.bodyB.node as? SKSpriteNode
    } else {
      return nil
    }
  }
}
