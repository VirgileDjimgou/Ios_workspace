//
//  ArrowView.swift
//  ios-schatz
//
//  Created by Michael Kofler on 19.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

@IBDesignable class ArrowView: UIView {
  // Farbe des Pfeils
  @IBInspectable var color:UIColor = UIColor.blackColor()

  // Richtung 0 = nach rechts, 90 = nach oben,
  // 180 = nach links, 270 = nach unten
  @IBInspectable var heading:Double = 0.0   {
    didSet {              // bei Änderung neuzeichnen
      setNeedsDisplay()
    }
  }
  
  // Methode, um den Inhalt des Views zu zeichnen
  override func drawRect(rect: CGRect) {
    
    let rad = heading / 180.0 * M_PI;
    
    let side   = min(frame.size.width, frame.size.height)
    let side2  = side/2             // halbe Seitenlänge
    let radius1 = side2 * 0.95      // Radius außen
    let radius2 = side2 * 0.25      // Radius innen
    let x0 = frame.size.width / 2   // Mittelpunkt
    let y0 = frame.size.height / 2
    
    let x1 = x0 + radius1 * CGFloat(cos(rad))  // Spitze
    let y1 = y0 - radius1 * CGFloat(sin(rad))
    let x2 = x0 + radius1 * CGFloat(cos(rad + M_PI * 0.8))
    let y2 = y0 - radius1 * CGFloat(sin(rad + M_PI * 0.8))
    let x3 = x0 + radius2 * CGFloat(cos(rad + M_PI))  // unten
    let y3 = y0 - radius2 * CGFloat(sin(rad + M_PI))
    let x4 = x0 + radius1 * CGFloat(cos(rad + M_PI * 1.2))
    let y4 = y0 - radius1 * CGFloat(sin(rad + M_PI * 1.2))

   
    let myBezier = UIBezierPath()
    myBezier.moveToPoint(CGPoint(x: x1, y: y1))
    myBezier.addLineToPoint(CGPoint(x: x2, y: y2))
    myBezier.addLineToPoint(CGPoint(x: x3, y: y3))
    myBezier.addLineToPoint(CGPoint(x: x4, y: y4))
    myBezier.closePath()
    color.setFill()
    myBezier.fill()
    color.setStroke()
    myBezier.stroke()
    
    
  }
}
