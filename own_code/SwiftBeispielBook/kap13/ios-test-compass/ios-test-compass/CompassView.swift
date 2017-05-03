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
  @IBInspectable var color:UIColor = UIColor.blackColor()
  
  // Farbe für die nach Norden zeigende Kompassspitze
  @IBInspectable var northColor:UIColor = UIColor.redColor()
  
  
  // Inhalt des Steuerelements zeichnen
  override func drawRect(rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()
    let rad = heading / 180.0 * M_PI  // Winkel im Zahlenbereich 0 bis 2*Pi
    
    // Kompassgröße
    let side   = min(frame.size.width, frame.size.height)
    let side2  = side/2
    let radout = side2 * 0.95  // Radius zur Spitze
    let radin  = side2 * 0.20  // Radius für Ost/West-Punkte
    
    // Kompassspitze Nord
    let xnorth = side2 - radout * CGFloat(sin(rad))
    let ynorth = side2 - radout * CGFloat(cos(rad))
    
    // Kompassspitze Süd
    let xsouth = side2 - radout * CGFloat(sin(rad + M_PI))
    let ysouth = side2 - radout * CGFloat(cos(rad + M_PI))
    
    // Kompassseite Ost/West
    let xeast  = side2 - radin  * CGFloat(sin(rad + M_PI_2))
    let yeast  = side2 - radin  * CGFloat(cos(rad + M_PI_2))
    let xwest  = side2 - radin  * CGFloat(sin(rad + 3 * M_PI_2))
    let ywest  = side2 - radin  * CGFloat(cos(rad + 3 * M_PI_2))
    
    // Kompasseite Ost/West für farblich abgesetzte Spitze
    let xeast2  = (2 * xnorth + xeast) / 3
    let yeast2  = (2 * ynorth + yeast) / 3
    let xwest2  = (2 * xnorth + xwest) / 3
    let ywest2  = (2 * ynorth + ywest) / 3
    
    // Kreis
    CGContextSetLineWidth(context, 2.0)
    CGContextSetStrokeColorWithColor(context, color.CGColor)
    UIColor.blackColor().set()
    CGContextAddArc(context,
                    side2, side2,             // x, y
                    side2 - 2,                // radius
                    0.0, CGFloat(M_PI * 2.0), 1) // Start- und Endwinkel
    CGContextStrokePath(context)

    /*
    // Kompasslinie
    CGContextSetLineWidth(context, 2.0)
    CGContextSetStrokeColorWithColor(context, red)
    CGContextMoveToPoint(context, side2, side2)
    CGContextAddLineToPoint(context, side2 - radout * CGFloat(sin(rad)),
                                     side2 - radout * CGFloat(cos(rad)))
    CGContextStrokePath(context)
    */
    
    // Kompassnadelspitze (rot)
    CGContextSetLineWidth(context, 1.0)
    CGContextSetFillColorWithColor(context, northColor.CGColor)
    CGContextSetStrokeColorWithColor(context, northColor.CGColor)
    CGContextMoveToPoint(context, xnorth, ynorth)
    CGContextAddLineToPoint(context, xeast, yeast)
    CGContextAddLineToPoint(context, xwest, ywest)
    CGContextAddLineToPoint(context, xnorth, ynorth)
    CGContextDrawPath(context, CGPathDrawingMode.FillStroke)   // zuerst Stroke, dann Fill
    
    // Kompassnadel schwarz (Norden)
    CGContextSetFillColorWithColor(context, color.CGColor)
    CGContextSetStrokeColorWithColor(context, color.CGColor)
    CGContextMoveToPoint(context,    xeast2, yeast2)
    CGContextAddLineToPoint(context, xeast,  yeast)
    CGContextAddLineToPoint(context, xwest,  ywest)
    CGContextAddLineToPoint(context, xwest2, ywest2)
    CGContextAddLineToPoint(context, xeast2, yeast2)
    CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
    
    // Kompassnadel weiß (Süden)
    CGContextSetStrokeColorWithColor(context, color.CGColor)
    CGContextMoveToPoint(context, xsouth, ysouth)
    CGContextAddLineToPoint(context, xeast, yeast)
    CGContextAddLineToPoint(context, xwest, ywest)
    CGContextAddLineToPoint(context, xsouth, ysouth)
    CGContextStrokePath(context)  // nur Stroke
  }
}
