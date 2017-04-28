//
//  ThirdViewController.swift
//  ios-animation
//
//  Created by Michael Kofler on 05.08.15.
//  Copyright © 2015 Michael Kofler. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
  @IBOutlet weak var btn1: UIButton!
  @IBOutlet weak var btn2: UIButton!
  @IBOutlet weak var btn3: UIButton!
  @IBOutlet weak var btn4: UIButton!
  
  @IBAction func switch1changed(_ sender: UISwitch) {
    sender.isOn ?  show(btn1) : hide(btn1)
  }
  @IBAction func switch2changed(_ sender: UISwitch) {
    sender.isOn ?  show(btn2) : hide(btn2)
  }
  @IBAction func switch3changed(_ sender: UISwitch) {
    sender.isOn ?  show(btn3) : hide(btn3)
  }
  @IBAction func switch4changed(_ sender: UISwitch) {
    sender.isOn ?  show(btn4) : hide(btn4)
  }
  

  // UIView in Stack-View ein- und ausblenden
  func show(_ v: UIView) {
    UIView.animate(withDuration: 0.35) {
      v.isHidden = false
      v.alpha = 1
    }
  }
  func hide(_ v: UIView) {
    UIView.animate(withDuration: 0.35) {
      v.isHidden = true
      v.alpha = 0
    }
  }
}
