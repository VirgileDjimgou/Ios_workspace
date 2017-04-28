//
//  main.swift
//  macos-pacman-bitmaps
//
//  Created by Michael Kofler on 11.07.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import Cocoa

// Bitmap als PNG-Datei speichern
func savePNG(_ bitmap: NSBitmapImageRep, filename: String)  {
  let props: [String: AnyObject] = [:]
  let png = bitmap.representation(using: .PNG,
                                  properties: props)
  _ = try? png!.write(to: URL(fileURLWithPath: filename),
                      options: [])
}

// Pac-Man-Figur in Bitmap zeichnen
func drawPacman(_ size: Int,
                bitmap: NSBitmapImageRep,
                angle: Double)
{
  let dSize = Double(size)
  let ctx = NSGraphicsContext(bitmapImageRep: bitmap)!
  NSGraphicsContext.setCurrent(ctx)
  
  let gradient = NSGradient(
        starting: NSColor(white: 0.95, alpha: 1),
        ending: NSColor(white:   0.75, alpha: 1))
  
  // Kreis
  let quad = NSRect(x: 0, y: 0, width: size, height: size)
  let circle = NSBezierPath(ovalIn: quad)
  gradient?.draw(in: circle, angle: 0)
  
  // Mund
  ctx.saveGraphicsState()
  ctx.compositingOperation = .clear
  let mouth = NSBezierPath()
  mouth.move(to: NSPoint(x: size/2, y: size/2))
  mouth.line(to: NSPoint(
    x: dSize * (0.5 + cos(angle / 360.0 * .pi)),
    y: dSize * (0.5 + sin(angle / 360.0 * .pi))))
  mouth.line(to: NSPoint(
    x: dSize * (0.5 + cos(angle / 360.0 * .pi)),
    y: dSize * (0.5 - sin(angle / 360.0 * .pi))))
  mouth.close()
  mouth.fill()
  ctx.restoreGraphicsState()
  
}

let home = NSHomeDirectory()
let size=128
for  i in 0...7 {
  let bmp = NSBitmapImageRep(bitmapDataPlanes: nil,
                             pixelsWide: size,
                             pixelsHigh: size,
                             bitsPerSample: 8,
                             samplesPerPixel: 4,
                             hasAlpha: true,
                             isPlanar: false,
                             colorSpaceName: NSDeviceRGBColorSpace,
                             bytesPerRow: 0,
                             bitsPerPixel: 0)!
  drawPacman(128, bitmap: bmp, angle: 10 + Double(i)*8.0)
  savePNG(bmp, filename: "\(home)/player-\(i).png")
}

