//
//  CompassView.swift
//  ios-test-compass
//
//  Created by Michael Kofler on 27.02.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

@IBDesignable class CompassView: UIView {
  
  @IBInspectable var heading:Double = 0.0   {   // Kompassrichtung in Grad, 0 = Norden
    didSet {              // bei Änderung neuzeichnen
      setNeedsDisplay()
    }
  }
  
  // Farbe für die Kompassrose und die Nadel
  @IBInspectable var color:UIColor = UIColor.black
  
  // Farbe für die nach Norden zeigende Kompassspitze
  @IBInspectable var northColor:UIColor = UIColor.red

  
  // Inhalt des Steuerelements zeichnen
  //  override func draw(_ rect: CGRect) {
  //
  //    let context = UIGraphicsGetCurrentContext()
  //    context?.setLineWidth(3)
  //    UIColor.red.set()
  //    let start = CGPoint(x: 10, y: 20)   // links oben
  //    let end   = CGPoint(x: 400, y: 900)
  //    context?.move(to: start)
  //    context?.addLine(to: end)
  //    context?.strokePath()
  //  }
  
  // Inhalt des Steuerelements zeichnen
  override func draw(_ rect: CGRect) {

    let context = UIGraphicsGetCurrentContext()
    let rad = heading / 180.0 * .pi  // Winkel im Zahlenbereich 0 bis 2*Pi
    
    // Kompassgröße
    let side   = min(frame.size.width, frame.size.height)
    let side2  = side/2
    let radout = side2 * 0.95  // Radius zur Spitze
    let radin  = side2 * 0.20  // Radius für Ost/West-Punkte
    
    // Kompassspitze Nord
    let xnorth = side2 - radout * CGFloat(sin(rad))
    let ynorth = side2 - radout * CGFloat(cos(rad))
    
    // Kompassspitze Süd
    let xsouth = side2 - radout * CGFloat(sin(rad + .pi))
    let ysouth = side2 - radout * CGFloat(cos(rad + .pi))
    
    // Kompassseite Ost/West
    let xeast  = side2 - radin  * CGFloat(sin(rad + .pi / 2))
    let yeast  = side2 - radin  * CGFloat(cos(rad + .pi / 2))
    let xwest  = side2 - radin  * CGFloat(sin(rad + 3 * .pi / 2))
    let ywest  = side2 - radin  * CGFloat(cos(rad + 3 * .pi / 2))
    
    // Kompasseite Ost/West für farblich abgesetzte Spitze
    let xeast2  = (2 * xnorth + xeast) / 3
    let yeast2  = (2 * ynorth + yeast) / 3
    let xwest2  = (2 * xnorth + xwest) / 3
    let ywest2  = (2 * ynorth + ywest) / 3
    
    // Kreis
    context?.setLineWidth(2.0)
    context?.setStrokeColor(color.cgColor)
    UIColor.black.set()
    context?.addArc(center: CGPoint(x: side2, y: side2),
                    radius: side2 - 2,
                    startAngle: 0.0,     // Start- und Endwinkel
                    endAngle: .pi * 2,
                    clockwise: true)
    context?.strokePath()

    
    // Kompassnadelspitze (rot)
    context?.setLineWidth(1.0)
    context?.setFillColor(northColor.cgColor)
    context?.setStrokeColor(northColor.cgColor)
    context?.move(to: CGPoint(x: xnorth, y: ynorth))
    context?.addLine(to: CGPoint(x: xeast, y: yeast))
    context?.addLine(to: CGPoint(x: xwest, y: ywest))
    context?.addLine(to: CGPoint(x: xnorth, y: ynorth))
    context?.drawPath(using: .fillStroke)   // zuerst Stroke, dann Fill
    
    // Kompassnadel schwarz (Norden)
    context?.setFillColor(color.cgColor)
    context?.setStrokeColor(color.cgColor)
    context?.move(to: CGPoint(x: xeast2, y: yeast2))
    context?.addLine(to: CGPoint(x: xeast,  y: yeast))
    context?.addLine(to: CGPoint(x: xwest,  y: ywest))
    context?.addLine(to: CGPoint(x: xwest2, y: ywest2))
    context?.addLine(to: CGPoint(x: xeast2, y: yeast2))
    context?.drawPath(using: .fillStroke)
    
    // Kompassnadel weiß (Süden)
    context?.setStrokeColor(color.cgColor)
    context?.move(to: CGPoint(x: xsouth, y: ysouth))
    context?.addLine(to: CGPoint(x: xeast, y: yeast))
    context?.addLine(to: CGPoint(x: xwest, y: ywest))
    context?.addLine(to: CGPoint(x: xsouth, y: ysouth))
    context?.strokePath()  // nur Stroke
  }
}
