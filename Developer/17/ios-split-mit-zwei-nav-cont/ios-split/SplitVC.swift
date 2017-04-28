//
//  SplitVC.swift
//  ios-split
//
//  Created by Michael Kofler on 31.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit


class SplitVC: UISplitViewController,
               UISplitViewControllerDelegate {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.delegate = self
  }
  
  // beim Programmstart Liste anzeigen (nicht Detail)
  // http://stackoverflow.com/questions/25875618
  func splitViewController(
       _ splitViewController: UISplitViewController,
       collapseSecondary secondaryViewController: UIViewController,
       onto primaryViewController: UIViewController)
    -> Bool
  {
    return true
  }
}
