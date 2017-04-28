//
//  IconClass.swift
//  macos-icon-resize
//
//  Created by Michael Kofler on 25.04.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

// es gibt drei vordefinierte Sets von Icons:
// für iOS, macOS und watchOS
enum IconSet {
  case iOS, macOS, watchOS
}

enum RetinaType {
  case x1  // kein Retina
  case x2  // Retina (doppelte Auflösung)
  case x3  // Super Retina (dreifache Auflösung, iPhone 6 Plus)
}

// beschreibt eine Icon-Größe
// sidelength: Icon-Quadrat-Seitenbreite in Pixel
// x1, x2, x3: normal, Retina, Super-Retina (z.B. iPhone 6 Plus)
// selected1, -2, -3: ist das betreffende Icon im Table View ausgewählt
struct IconSize {
  var sidelength: Double
  var x1, x2, x3: Bool

  // MARK: Initialisierung
  
  // init-Funktion
  init(_ sidelength: Double, _ x1: Bool, _ x2: Bool, _ x3: Bool)
  {
    self.sidelength = sidelength
    self.x1 = x1
    self.x2 = x2
    self.x3 = x3
  }

  // liefert ein Array von IconSize-Objekten
  // für iOS, OS X oder Apple Watch
  static func getSizes(set: IconSet) -> [IconSize] {
    switch set {
    case .iOS:     return IconSize.iosSizes()
    case .macOS:   return IconSize.macosSizes()
    case .watchOS: return IconSize.watchSizes()
    }
  }
  
  // zur Initialisierung
  private static func iosSizes() -> [IconSize] {
    // für iOS >= 7
    return [
      // iPhone
      IconSize(20, false, true, true),
      IconSize(29, false, true, true),
      IconSize(40, false, true, true),
      IconSize(60, false, true, true),
      // iPad
      IconSize(20, false, true, true),
      IconSize(29, true, true, false),
      IconSize(40, true, true, false),
      IconSize(76, true, true, false),
      IconSize(83.5, false, true, false)
    ]
  }
  
  private static func macosSizes() -> [IconSize] {
    return [
      IconSize(16, true, true, false),
      IconSize(32, true, true, false),
      IconSize(128, true, true, false),
      IconSize(256, true, true, false),
      IconSize(512, true, true, false)
    ]
  }
  
  private static func watchSizes() -> [IconSize] {
    // für Watchkit
    return [
      IconSize(24,   false, true, false),  // Notif. Center
      IconSize(27.5, false, true, false),  // Notif. Center
      IconSize(29,   false, true, true),   // Comp. Sett.
      IconSize(40,   false, true, false),  // Home Screen
      IconSize(86,   false, true, false),  // Short Look
      IconSize(98,   false, true, false)   // Short Look
    ]
    
    // veraltet
    //    return [
    //      IconSize(24,   false, true, false),
    //      IconSize(27.5, false, true, false),
    //      IconSize(29,   false, true, true),
    //      IconSize(40,   false, true, false),
    //      IconSize(44,   false, true, false),
    //      IconSize(86,   false, true, false),
    //      IconSize(98, false, true, false)
    //    ]
  }
  
  // MARK: Bitmaps skalieren
  
  // NSImage --> verkleinerte CGImage
  private func scale(_ icon: NSImage, to type: RetinaType)
    -> CGImage?
  {
    // neue Größe
    let newlength: Int
    switch type {
    case .x1: newlength = Int(sidelength)
    case .x2: newlength = Int(sidelength * 2)
    case .x3: newlength = Int(sidelength * 3)
    }

    
    // NSImage --> CGimage
    var rect = CGRect(x: 0,
                      y: 0,
                      width: icon.size.width,
                      height: icon.size.height)
    if let cgimg = icon.cgImage(forProposedRect: &rect,
                                context: nil,
                                hints: nil)
    {
      // CGImage skalieren
      let colorSpace = CGColorSpaceCreateDeviceRGB()
      let bitmapInfo = CGBitmapInfo(rawValue:
        CGImageAlphaInfo.premultipliedLast.rawValue)
      let context = CGContext(data: nil,
                              width: newlength,
                              height: newlength,
                              bitsPerComponent: 8,
                              bytesPerRow: 0,
                              space: colorSpace,
                              bitmapInfo: bitmapInfo.rawValue)
      context!.interpolationQuality = .high
      let newrect = CGRect(x: 0, y: 0,
                           width: newlength, height: newlength)
      // skalierte Bitmap zeichnen
      context?.draw(cgimg, in: newrect)
      // als CGImage zurückgeben
      return context?.makeImage()
    }
    
    // etwas ist schief gegangen
    return nil
  }

  // MARK: Bitmaps speichern
  
  // Icon skalieren und im angegebenen bzw. im temporären 
  // Verzeichnis speichern; gibt den Dateinamen zurück
  func save(_ icon: NSImage,
            type: RetinaType,
            folder: String ) -> String
  {
    let name = IconSize.iconName(prefix: "icon_",
                                 sidelength: sidelength,
                                 type: type)
    let fname = NSString(string: folder)
      .appendingPathComponent(name)
    if let img = scale(icon, to: type) {
      if savePNG(img, in: fname) {
        return fname  // alles bestens, Dateinamen zurückgeben
      }
    }
    // etwas ist schief gegangen
    return ""
  }
  
  // CGImage in PNG-Datei speichern
  private func savePNG(_ img: CGImage, in fname: String) -> Bool {
    let url = URL(fileURLWithPath: fname)
    if let dest = CGImageDestinationCreateWithURL(
      url as CFURL, kUTTypePNG, 1, nil)
    {
      CGImageDestinationAddImage(dest, img, nil)
      return CGImageDestinationFinalize(dest)
    }
    
    // etwas ist schief gegangen
    return false
  }
  
  
  // Icon-Dateinamen zusammenbasteln
  // iconName(prefix: "icon_", sidelength: 40, type: X2) 
  // liefert icon_40x40@2x.png
  static func iconName(prefix: String,
                       sidelength: Double,
                       type rtype: RetinaType) -> String
  {
    // sidelength in NSNumber umwandeln
    let sideNmb = NSNumber(value: sidelength)
    
    // mit einer Nachkommastelle darstellen, Komma als Trenner
    let formatter = NumberFormatter()
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 1
    formatter.locale = Locale(identifier: "en_US")
    let txt = formatter.string(from: sideNmb)!
    
    var result = prefix + txt + "x" + txt
    if rtype == .x2 { result += "@2x" }
    if rtype == .x3 { result += "@3x" }
    result += ".png"
    
    return result
  }


  
  
}
