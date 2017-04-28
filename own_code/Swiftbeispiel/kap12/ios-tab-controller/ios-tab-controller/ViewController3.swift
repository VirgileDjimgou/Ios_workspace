//
//  ViewController3.swift
//  ios-tab-controller
//
//  Created by Michael Kofler on 31.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {
  @IBAction func btnActivateView1(sender: UIButton) {
    tabBarController!.selectedIndex=0
  }
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    print("viewDidAppear in VC3")
  }
 }
