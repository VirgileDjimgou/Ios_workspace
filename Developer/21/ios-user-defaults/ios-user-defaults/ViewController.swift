//
//  ViewController.swift
//  ios-user-defaults
//
//  Created by Michael Kofler on 21.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var txtName: UITextField!
  @IBOutlet weak var dtBirth: UIDatePicker!
  
  let keyDate = "Birthdate"
  let keyName = "Name"
  
  let ud = UserDefaults.standard
  
  // zuletzt gespeicherten Namen + Geburtsdatum
  // aus den User-Defaults laden
  override func viewDidLoad() {
    super.viewDidLoad()
    txtName.text = ud.string(forKey: keyName)
    if let obj = ud.object(forKey: keyDate),
       let bdate = obj as? Date
    {
      dtBirth.date = bdate
    }


    //    // Ort, wo die User-Defaults gespeichert werden
    //    // (plus Preferences/<bundle-id>.plist)
    //    let urls = FileManager.default.urls(for: .libraryDirectory,
    //                                        in: .userDomainMask)
    //    print(urls.first!.path)
    //
    //    // interne Darstellung der User-Defaults
    //    print(ud.dictionaryRepresentation())
  }

  // Änderungen sofort speichern
  @IBAction func txtNameEditingChanged(_ sender: UITextField) {
    ud.set(txtName.text, forKey: keyName)
  }
  @IBAction func dtBirthChanged(_ sender: UIDatePicker) {
    ud.set(dtBirth.date, forKey: keyDate)
  }
}

