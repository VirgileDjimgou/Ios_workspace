//
//  ViewController.swift
//  ios-layout-code
//
//  Created by Michael Kofler on 03.04.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    // todo: richtige Farbe, callback
    
    super.viewDidLoad()
    let btn = UIButton(type: .system)
    btn.setTitle("Dieser Button wurde mit Code erzeugt", for: UIControlState())
    btn.addTarget(self,
      action: #selector(ViewController.buttonAction(_:)),
      for: .touchUpInside)
    view.addSubview(btn)

    // ohne Autolayout: Position einfach fixieren
    //btn.frame = CGRectMake(0, 0, 100, 50)

    // mit Autolayout: zuerst automatische Constraints eliminieren
    btn.translatesAutoresizingMaskIntoConstraints = false

//    // Button links oben
//    let left = NSLayoutConstraint(
//      item:       btn,
//      attribute:  .Left,
//      relatedBy:  .Equal,
//      toItem:     self.view,
//      attribute:  .Left,
//      multiplier: 1,
//      constant:   8)
//    let top = NSLayoutConstraint(
//      item:       btn,
//      attribute:  .Top,
//      relatedBy:  .Equal,
//      toItem:     self.topLayoutGuide,
//      attribute:  .Bottom,
//      multiplier: 1,
//      constant:   0)
//    view.addConstraint(left)
//    view.addConstraint(top)

    // alternativ: Button zentriert
    let center1 = NSLayoutConstraint(
      item:       btn,
      attribute:  .centerX,
      relatedBy:  .equal,
      toItem:     self.view,
      attribute:  .centerX,
      multiplier: 1,
      constant:   0)
    let center2 = NSLayoutConstraint(
      item:       btn,
      attribute:  .centerY,
      relatedBy:  .equal,
      toItem:     self.view,
      attribute:  .centerY,
      multiplier: 1,
      constant:   0)
    view.addConstraint(center1)
    view.addConstraint(center2)
    
  }

  func buttonAction(_ sender:UIButton!) {
    print(sender.currentTitle)
  }
  
}

