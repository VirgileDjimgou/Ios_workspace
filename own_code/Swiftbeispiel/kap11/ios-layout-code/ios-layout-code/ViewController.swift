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
    let btn = UIButton(type: .System)
    btn.setTitle("Dieser Button wurde mit Code erzeugt", forState: .Normal)
    btn.addTarget(self,
      action: #selector(ViewController.buttonAction(_:)),
      forControlEvents: .TouchUpInside)
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
      attribute:  .CenterX,
      relatedBy:  .Equal,
      toItem:     self.view,
      attribute:  .CenterX,
      multiplier: 1,
      constant:   0)
    let center2 = NSLayoutConstraint(
      item:       btn,
      attribute:  .CenterY,
      relatedBy:  .Equal,
      toItem:     self.view,
      attribute:  .CenterY,
      multiplier: 1,
      constant:   0)
    view.addConstraint(center1)
    view.addConstraint(center2)
    
  }

  func buttonAction(sender:UIButton!) {
    print(sender.currentTitle)
  }
  
}

