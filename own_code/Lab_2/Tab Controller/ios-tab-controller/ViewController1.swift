//
//  ViewController1.swift
//  ios-tab-controller
//
//  Created by Michael Kofler on 31.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tabBarController!.delegate =
      UIApplication.shared.delegate as! AppDelegate
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    print("viewDidAppear in VC1")
    // Schleife über alle View Controller
    let tab = tabBarController!
    if let vcs = tab.viewControllers {
      for vc in vcs {
        let title = vc.title ?? "kein Titel"
        let loaded = vc.isViewLoaded
        print("Titel = \(title), isViewLoaded = \(loaded)")
      }
    }
  }
}
