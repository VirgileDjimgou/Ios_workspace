//
//  ViewController.swift
//  ios-nav-controller
//
//  Created by Michael Kofler on 12.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBAction func btnToVC4(_ sender: UIButton) {
    // Segue manuell ausführen
    performSegue(withIdentifier: "SegueToVC4", sender: self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //    appDelegate.vc1 = self
  }
  
  override func prepare(for segue: UIStoryboardSegue,
                        sender: Any?)
  {
    print("prepareForSeque in VC1")
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("viewWillAppear in VC1")
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    print("viewWillDisappear in VC1")
  }
  override func didMove(toParentViewController
                          parent: UIViewController?)
  {
    super.didMove(toParentViewController: parent)
    if parent == nil {
      print("didMove(toParentVC) in VC1 (Rückwärtsnavigation)")
    }
  }

}

