//
//  MyView.swift
//  osx-mouse
//
//  Created by Michael Kofler on 05.05.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

@IBDesignable
class MyView: UIView {
  
  var circles = [Circle]()
  var currentColor: UIColor = .red
  
  // offensichtlich ohne Relevanz für pressesXxx-Methoden
  //  override var isFirstResponder: Bool {
  //    return true
  //  }
  //  override func becomeFirstResponder() -> Bool {
  //    return true
  //  }
  //  override func resignFirstResponder() -> Bool {
  //    return true
  //  }
  //  override var canBecomeFirstResponder: Bool {
  //    return true
  //  }
  //  override var canResignFirstResponder: Bool {
  //    return true
  //  }
  
  
  override func draw(_ dirtyRect: CGRect) {
    // Hintergrund
    UIColor.white.setFill()
    let bez = UIBezierPath(rect: dirtyRect)
    bez.fill()
    
    // falls nicht NSView als Basisklasse,
    // sondern z. B. NSImageView:
    // Inhalt des Steuerelements zeichnen
    // super.drawRect(dirtyRect)
    
    // Vordergrund
    for c in circles {
      let path = UIBezierPath()
      path.addArc(
        withCenter: CGPoint( x: c.x,
                             y: c.y),
        radius: c.radius,
        startAngle: 0,
        endAngle: 360,
        clockwise:  true)
      c.color.set()
      path.lineWidth = c.lineWidth
      path.stroke()
    }
  }
  
  // Beginn der Bewegung: neue, zufällige Farbe festlegen
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    currentColor = UIColor(red: cRnd(),  green: cRnd(),
                           blue: cRnd(), alpha: 1)
  }
  
  //  Verlauf der Bewegung
  override func touchesMoved(_ touches: Set<UITouch>,
                             with event: UIEvent?) {
    
    let pt = touches.first!.location(in: self)
    circles.append(Circle(x: pt.x, y: pt.y,
                          radius: 20,
                          lineWidth: 4,
                          color: currentColor))
    
    // neu zu zeichnenden Bereich festlegen, nur
    // diesen neu zeichnen
    // radius 20 + linewidth 4 + 1 --> 25
    let rect = CGRect(x: pt.x - 25,
                      y: pt.y - 25,
                      width: 2 * 25,
                      height: 2 * 25)
    setNeedsDisplay(rect)
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    // nothing to do
  }
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    // nothing to do
    print("cancelled")
  }
  
  // Hilfsfunktion, erzeugt CGFloat-Zufallszahl zwischen 0 und 1
  private func cRnd() -> CGFloat { return CGFloat(drand48()) }
  
  
    
  
  
  
}
