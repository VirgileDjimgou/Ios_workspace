//
//  InfoVC.swift
//  ios-currency-calculator
//
//  Created by Michael Kofler on 19.09.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit

class InfoVC: UIViewController {
  
  @IBOutlet weak var infoBtn: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Cover des Swift-Buchs unverzerrt anzeigen
    // infoBtn.imageView?.contentMode = .scaleAspectFit
  }
  
  // @IBAction func infoBtnClick(_ sender: AnyObject) {
  // der Link verstösst gegen Regel Business - 3.1.1 der
  // App-Store-Regeln
  
  //    let url = URL(string: "https://kofler.info/buecher/swift")!
  //    UIApplication.shared.open(url)
  // }
  
  
}
