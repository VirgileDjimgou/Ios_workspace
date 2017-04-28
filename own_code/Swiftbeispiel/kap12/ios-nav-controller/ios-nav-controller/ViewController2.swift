//
//  ViewController2.swift
//  ios-nav-controller
//
//  Created by Michael Kofler on 31.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    print("prepareForSeque in VC2")
  }
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    print("viewWillAppear in VC2")
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    print("viewWillDisappear in VC2")
  }
  
  override func didMoveToParentViewController(parent: UIViewController?) {
    super.didMoveToParentViewController(parent)
    if parent == nil {
      print("didMoveToParentVC in VC2 (Rückwärtsnavigation)")
    }
  }
  
}
