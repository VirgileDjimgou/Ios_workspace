//
//  CompassView.swift
//  ios-test-compass
//
//  Created by Michael Kofler on 27.02.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

@IBDesignable class CompassView: UIView {
  
  // Kompassrichtung in Grad, 0 = Norden
  @IBInspectable var heading:Double = 0.0   {
    didSet {              // bei Änderung neu zeichnen
      setNeedsDisplay()
    }
  }
  
  // Farbe für die Kompassrose und die Nadel
  @IBInspectable var color: UIColor = .black
  
  // Farbe für die nach Norden zeigende Kompassspitze
  @IBInspectable var northColor: UIColor = .red
  
  
  // Inhalt des Steuerelements zeichnen
  override func draw(_ rect: CGRect) {
    let rad = heading / 180.0 * .pi  // Winkel im Zahlenbereich 0 bis 2*Pi
    
    // Kompassgröße
    let side   = Double(min(bounds.size.width,
                            bounds.size.height))
    let side2  = side/2
    let radout = side2 * 0.95  // Radius zur Spitze
    let radin  = side2 * 0.20  // Radius für Ost/West-Punkte
    
    // Kompassspitze Nord
    let xnorth = side2 - radout * sin(rad)
    let ynorth = side2 - radout * cos(rad)
    
    // Kompassspitze Süd
    let xsouth = side2 - radout * sin(rad + .pi)
    let ysouth = side2 - radout * cos(rad + .pi)
    
    // Kompassseite Ost/West
    let xeast  = side2 - radin  * sin(rad + .pi / 2)
    let yeast  = side2 - radin  * cos(rad + .pi / 2)
    let xwest  = side2 - radin  * sin(rad + 3 * .pi / 2)
    let ywest  = side2 - radin  * cos(rad + 3 * .pi / 2)
    
    // Kompasseite Ost/West für farblich abgesetzte Spitze
    let xeast2  = (2 * xnorth + xeast) / 3
    let yeast2  = (2 * ynorth + yeast) / 3
    let xwest2  = (2 * xnorth + xwest) / 3
    let ywest2  = (2 * ynorth + ywest) / 3
    
    // Kreis
    let circle = UIBezierPath(arcCenter: CGPoint(x: side2, y: side2),
                              radius: CGFloat(side2 - 2),
                              startAngle: 0,
                              endAngle: 2 * .pi,
                              clockwise: true)
    UIColor.black.setStroke()
    circle.stroke()
    
    
    // Kompassnadelspitze Nord
    northColor.setFill()
    northColor.setStroke()
    with( UIBezierPath() ) {
      $0.move(to: CGPoint(x: xnorth, y: ynorth))
      $0.addLine(to: CGPoint(x: xeast, y: yeast))
      $0.addLine(to: CGPoint(x: xwest, y: ywest))
      $0.addLine(to: CGPoint(x: xnorth, y: ynorth))
      $0.fill()    // Fill und Stroke
      $0.stroke()
    }
    
    // Kompassnadelbasis Nord
    color.setFill()
    color.setStroke()
    with( UIBezierPath() ) {
      $0.move(to: CGPoint(x: xeast2, y: yeast2))
      $0.addLine(to: CGPoint(x: xeast,  y: yeast))
      $0.addLine(to: CGPoint(x: xwest,  y: ywest))
      $0.addLine(to: CGPoint(x: xwest2, y: ywest2))
      $0.addLine(to: CGPoint(x: xeast2, y: yeast2))
      $0.fill()
      $0.stroke()
    }
    
    // Kompassnadel Süden
    color.setStroke()
    with( UIBezierPath() ) {
      $0.move(to: CGPoint(x: xsouth, y: ysouth))
      $0.addLine(to: CGPoint(x: xeast, y: yeast))
      $0.addLine(to: CGPoint(x: xwest, y: ywest))
      $0.addLine(to: CGPoint(x: xsouth, y: ysouth))
      $0.stroke()  // nur Stroke
    }
  }
}
