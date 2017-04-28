//
//  ViewController.swift
//  tvos-remote
//
//  Created by Michael Kofler on 26.09.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    setupRecognizers()
  }

  // Alternative zu pressesBegan/-Ended:
  // Taps mit Gesture-Recognizer erkennen
  func setupRecognizers() {
    let tapRecognizer1 = UITapGestureRecognizer(
      target: self,
      action: #selector(ViewController.tappedLeft(_:)))
    tapRecognizer1.allowedPressTypes =
      [ NSNumber(value: UIPressType.leftArrow.rawValue) ]
    self.view.addGestureRecognizer(tapRecognizer1)
    
    let tapRecognizer2 = UITapGestureRecognizer(
      target: self,
      action: #selector(ViewController.tappedRight(_:)))
    tapRecognizer2.allowedPressTypes =
      [ NSNumber(value: UIPressType.rightArrow.rawValue) ]
    self.view.addGestureRecognizer(tapRecognizer2)
    
    
  }

  func tappedLeft(_ tapGR: UITapGestureRecognizer) {
    print("Tap Gesture: links")
  }
  func tappedRight(_ tapGR: UITapGestureRecognizer) {
    print("Tap Gesture: rechts")
  }
  

  // Reaktion auf Klicks auf die Tasten der Fernbedienung
  // sowie auf Berührungen (Taps) der Touchpad-Fläche
  override func pressesBegan(_ presses: Set<UIPress>,
                             with event: UIPressesEvent?)
  {
    super.pressesBegan(presses, with: event)
    for p in presses {
      let key = p.type
      switch key {
      case .select:
        print("Touchpad-Klick")
        
        
      case .downArrow:
        // Tap, nicht Klick!!!
        // Achtung, Taps nahe der Mitte werden häufig
        // falsch klassifiziert
        print("Touchpad-Tap am Rand: unten")
      case .upArrow:
        print("Touchpad-Tap am Rand: oben")
      case .leftArrow:
        print("Touchpad-Tap am Rand: links")
      case .rightArrow:
        print("Touchpad-Tap am Rand: rechts")
        
      case .menu:
        print("Menü")
        // führt automatisch zu Exit auf tvOS-Hauptebene,
        // sofern super.pressesBegan() aufgerufen wird
        
      case .playPause:
        print("Play/Pause")
        
      }
    }
  }
  
  //  override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
  //    super.pressesEnded(presses, with: event)
  //  }
  
}

