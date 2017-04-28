//
//  SaveVC.swift
//  ios-schatz
//
//  Created by Michael Kofler on 18.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class SaveVC: UIViewController, UITextFieldDelegate {
  @IBOutlet weak var posname: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    posname.delegate = self
  }

  // bei Return ausblenden
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    // Eingabe beenden, Tastatur ausblenden
    view.endEditing(true)
    // Segue zu View 2 initiieren
    performSegueWithIdentifier("SegueUnwindSaveToMain", sender: self)
    // 'Return' nicht als Eingabe weitergeben
    return false
  }

}
