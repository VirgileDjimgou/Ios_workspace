//
//  MyView.swift
//  ios-grafik
//
//  Created by Michael Kofler on 25.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit

class MyView: UIView {
  
  
  override func draw(_ rect: CGRect) {
    //    // Hintergrund abweichend von den Xcode-Einstellungen
    //    // zeichnen
    //    UIColor.gray.setFill()
    //    UIBezierPath(rect: rect).fill()
    
    // rote Linie zeichnen
    let start = CGPoint(x: 10, y: 20)   // links oben
    let end   = CGPoint(x: 400, y: 900) // rechts unten
    let line = UIBezierPath()
    line.move(to: start)     // Startpunkt festlegen
    line.addLine(to: end)    // Linie zum Endpunkt
    line.lineWidth = 3       // Linienbreite
    UIColor.red.setStroke()  // Farbe einstellen
    line.stroke()            // Linie zeichnen
    
    // Kreis
    let midpt = CGPoint(x: 250, y: 100)
    let circle = UIBezierPath(arcCenter:  midpt,
                              radius:     50,
                              startAngle: 0,
                              endAngle:   2 * .pi,
                              clockwise:  true)
    circle.lineWidth = 4
    UIColor.black.setStroke()
    UIColor.yellow.setFill()
    circle.fill()
    circle.stroke()
    
    // abgerundetes Rechteck mit strichlierter Linie
    let rrect = CGRect(x: 100, y: 220,
                       width: 200, height: 100)
    let rrectpath = UIBezierPath(roundedRect: rrect,
                                 cornerRadius: 10)
    rrectpath.lineWidth = 5
    let dashes:[CGFloat] = [4, 2]
    rrectpath.setLineDash(dashes, count: 2, phase: 0)
    UIColor.gray.setStroke()
    rrectpath.stroke()
    
    
    // gefülltes Polygon
    let pts = [
      CGPoint(x:  80, y: 400),
      CGPoint(x: 180, y: 450),
      CGPoint(x: 180, y: 490),
      CGPoint(x: 140, y: 520),
      CGPoint(x:  70, y: 410)
    ]
    let poly = UIBezierPath()
    poly.move(to: pts[0])
    for i in 1..<pts.count {
      poly.addLine(to: pts[i])
    }
    poly.close()
    UIColor.blue.setFill()
    poly.fill()
  }
  
  
}
