//
//  NewPopupVC.swift
//  ios-list4
//
//  Created by Michael Kofler on 22.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class NewPopupVC: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var txt: UITextField!
  
  // zulässige Modi: "new" und "edit"
  var mode = ""
  
  // zu ändernder Text und Eintrag (nur für Edit-Mode)
  var currentText = ""
  var currentRow = 0
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if mode == "new" {
      // Tastatur sofort einblenden
      txt.becomeFirstResponder()
    } else {
      // vorhandenen Text einstellen
      // Tastatur nicht gleich einblenden, da
      // dann u.U. der zu ändernde Eintrag verdeckt
      // ist und die Logik nicht erkennbar ist
      txt.text = currentText
    }
    txt.delegate = self           // Textfeld-Ereignisse verarbeiten
  }

  
  // Reaktion auf 'Return'
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // Eingabe beenden, Tastatur ausblenden
    view.endEditing(true)
    // Segue zu View 2 initiieren
    performSegue(withIdentifier: "SegueUnwindToMain",
                 sender: self)
    // 'Return' nicht als Eingabe weitergeben
    return false
  }

}
