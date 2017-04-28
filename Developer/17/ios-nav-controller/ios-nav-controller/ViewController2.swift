//
//  ViewController2.swift
//  ios-nav-controller
//
//  Created by Michael Kofler on 31.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    print("prepareForSeque in VC2")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("viewWillAppear in VC2")
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    print("viewWillDisappear in VC2")
  }
  
  override func didMove(toParentViewController
                         parent: UIViewController?)
  {
    super.didMove(toParentViewController: parent)
    if parent == nil {
      print("didMoveToParentVC in VC2 (Rückwärtsnavigation)")
    }
  }
  
}
