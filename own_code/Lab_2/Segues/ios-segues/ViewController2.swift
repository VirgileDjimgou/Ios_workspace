//
//  ViewController2.swift
//  ios-segues
//
//  Created by Michael Kofler on 12.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
  
  // var data:[Int]?
  
  @IBAction func unwindToView2(_ segue: UIStoryboardSegue) {
    // optional: segue-Parameter auswerten
  }

  override func viewDidLoad() {
    // zum Test, ob Speicher nach unwind
    // wieder freigegeben wird
    // data = Array(1...50_000_000)
  }
  
}
