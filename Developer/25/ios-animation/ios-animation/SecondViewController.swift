//
//  SecondViewController.swift
//  ios-animation
//
//  Created by Michael Kofler on 04.08.15.
//  Copyright © 2015 Michael Kofler. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
  
  @IBOutlet weak var imgview: UIImageView!
  
  // Bitmap ist anfänglich transparent
  override func viewDidLoad() {
    super.viewDidLoad()
    imgview.alpha=0
  }
  
  // nicht in viewDidLoad
  override func viewDidAppear(_ animated: Bool) {
    UIView.animate(withDuration: 2.5) {
        self.imgview.alpha = 1
      }
  }
  
}

