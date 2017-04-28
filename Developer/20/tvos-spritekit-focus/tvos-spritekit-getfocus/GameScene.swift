//
//  GameScene.swift
//  tvos-spritekit-getfocus
//
//  Created by Michael Kofler on 22.09.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
  
  override func didMove(to view: SKView) {
    self.backgroundColor = .white
    
    // zufällige Zufallszahlen
    srand48(Int(arc4random_uniform(100000000)))
    
    // zwanzig fokussierbare Quadrate
    for _ in 1...10   {
      let mySp = MySprite()
      mySp.size = CGSize(width: 200, height: 200)
      mySp.color = SKColor(red: cRnd(),
                           green: cRnd(),
                           blue: cRnd(),
                           alpha: 1)
      mySp.colorBlendFactor = 1
      mySp.position = CGPoint(x: 100 + cRnd()*1720,
                              y: 100 + cRnd()*880)
      mySp.zPosition = 1 + cRnd()
      mySp.alpha = 0.5  // halb-transparent
      mySp.isUserInteractionEnabled = true
      self.addChild(mySp)
    }
  }

  // Fokus-Wechsel
  override func didUpdateFocus(
    in context: UIFocusUpdateContext,
    with coordinator: UIFocusAnimationCoordinator)
  {
    print("focus")
    
    if let prev = context.previouslyFocusedItem as? MySprite {
      prev.alpha = 0.5
    }
    if let next = context.nextFocusedItem as? MySprite {
      next.alpha = 1
    }
  }
  
  
  // Hilfsfunktion, erzeugt CGFloat-Zufallszahl zwischen 0 und 1
  private func cRnd() -> CGFloat { return CGFloat(drand48()) }
}
