//
//  ViewController.swift
//  ios-segue-data
//
//  Created by Michael Kofler on 12.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var txtfield: UITextField!
  @IBOutlet weak var answerLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    answerLabel.text = ""
    txtfield.delegate = self  // Textfeld-Ereignisse verarbeiten
  }

  // Reaktion auf 'Return'
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // Eingabe beenden, Tastatur ausblenden
    view.endEditing(true)
    // Segue zu View 2 initiieren
    performSegue(withIdentifier: "SegueToView2", sender: self)
    // 'Return' nicht als Eingabe weitergeben
    return false
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let dest = segue.destination as? ViewController2 {
      dest.msg = txtfield.text!
    }
  }
  
  // Rückkehr aus View 2
  @IBAction func unwindToView1(_ segue: UIStoryboardSegue) {
    if let src = segue.source as? ViewController2 {
      // Antwort anzeigen
      answerLabel.text = src.txtfield.text
      // Textfeld leeren
      txtfield.text = ""
    }
  }

}

