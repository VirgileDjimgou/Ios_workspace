//
//  ViewController3.swift
//  ios-nav-controller
//
//  Created by Michael Kofler on 31.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {

  @IBAction func btnBackToVC1(_ sender: UIButton) {
    navigationController!.popToRootViewController(animated: true)
    // navigationController!.popViewControllerAnimated(true)
    // let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    // navigationController!.popToViewController(appDelegate.vc1!, animated: true)
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    print("prepareForSeque in VC3")
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("viewWillAppear in VC3")
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    print("viewWillDisappear in VC3")
  }
  override func didMove(toParentViewController parent: UIViewController?) {
    super.didMove(toParentViewController: parent)
    if parent == nil {
      print("didMoveToParentVC in VC3 (Rückwärtsnavigation)")
    }
  }


}
