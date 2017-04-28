//
//  ViewController.swift
//  ios-text
//
//  Created by Michael Kofler on 30.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
                      UITextFieldDelegate
{

  @IBOutlet weak var txtEmail: UITextField!
  @IBOutlet weak var txtPassword: UITextField!
  @IBOutlet weak var lblStatus: UILabel!
  
  // Initialisierung
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Fokus in erstes Textfeld, Tastatur anzeigen
    txtEmail.becomeFirstResponder()
    
    // Delegates für beide Textfelder
    txtEmail.delegate = self
    txtPassword.delegate = self
  }

  // auf die Eingabe von <Return> reagieren
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == txtEmail {
      // Return im E-Mail-Feld: weiter zum Passwort
      txtPassword.becomeFirstResponder()
    } else {
      // Return im Passwort-Feld: Login überprüfen
      _ = testLogin()
    }
    return false  // <Return> nicht als Eingabe verarbeiten
  }
  
  
  // Login-Button
  @IBAction func btnLogin(_ sender: UIButton) {
    _ = testLogin()
  }
  
  
  // Überprüfen, ob Login OK ist
  // OK bedeutet: E-Mail ist a@b.c
  private func testLogin() -> Bool {
    if txtEmail.text != "a@b.c" {
      lblStatus.text = "Unbekannte E-Mail-Adresse, verwenden Sie a@b.c."
      lblStatus.textColor = .red
      lblStatus.sizeToFit()
      txtEmail.becomeFirstResponder()
      return false
    } else if txtPassword.text != "1234" {
      lblStatus.text = "Falsches Passwort, verwenden Sie 1234."
      lblStatus.textColor = .red
      lblStatus.sizeToFit()
      txtPassword.becomeFirstResponder()
      return false
    }
    
    // OK, Tastatur ausblenden, true zurückgeben
    lblStatus.text = "OK"
    lblStatus.textColor = .green
    lblStatus.sizeToFit()
    self.view.endEditing(true)
    return true
  }


  // nur für Testzwecke, aktuelle Eingabe protokollieren
  @IBAction func mailEditingChanged(_ sender: UITextField) {
    print(txtEmail.text!)
  }
  @IBAction func passwordEditingChanged(_ sender: UITextField) {
    print(txtPassword.text!)
  }
}

