//
//  ViewController.swift
//  ios-nav-controller
//
//  Created by Michael Kofler on 12.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBAction func btnToVC4(sender: UIButton) {
    // Segue manuell ausführen
    performSegueWithIdentifier("SegueToVC4", sender: self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    // appDelegate.vc1 = self
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    print("prepareForSeque in VC1")
  }
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    print("viewWillAppear in VC1")
  }
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    print("viewWillDisappear in VC1")
  }
  override func didMoveToParentViewController(parent: UIViewController?) {
    super.didMoveToParentViewController(parent)
    if parent == nil {
      print("didMoveToParentVC in VC1 (Rückwärtsnavigation)")
    }
  }

}

