//
//  ViewController2.swift
//  ios-segue-data
//
//  Created by Michael Kofler on 12.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var txtfield: UITextField!
  @IBOutlet weak var msgLabel: UILabel!
  var msg = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    msgLabel.text = msg
    txtfield.delegate = self
  }
  
  // Reaktion auf 'Return'-Taste der Tastatur
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    view.endEditing(true)  // Eingabe abschließen, Tastatur ausblenden
    // Unwind Segue zu View 1 initiieren
    performSegue(withIdentifier: "UnwindToView1", sender: self)
    return false           // 'Return' nicht als eingegebenes Zeichen weiterleiten
  }
  
}
