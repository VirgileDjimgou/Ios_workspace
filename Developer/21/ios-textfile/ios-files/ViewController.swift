//
//  ViewController.swift
//  ios-files
//
//  Created by Michael Kofler on 24.02.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var txtView: UITextView!
  
  // zuletzt gespeicherten Text automatisch laden
  override func viewDidLoad() {
    txtView.layer.borderColor = UIColor.lightGray.cgColor
    txtView.layer.borderWidth = 1
    txtView.layer.cornerRadius = 6
    btnLoad()
  }
  
  // Inhalt des TextViews löschen
  @IBAction func btnNew() {
    txtView.text = ""
  }
  
  // Inhalt des TextViews in Document-Datei speichern
  @IBAction func btnSave() {
    if let url = docurl("data.txt") {
      do {
        try txtView.text.write(to: url,
          atomically: true,
          encoding: .utf8)
      } catch  {
        print(error)
      }
    }
  }
  
  // Inhalt des TextViews aus Document-Datei laden
  @IBAction func btnLoad() {
    if let url = docurl("data.txt") {
      do {
        txtView.text = try String(contentsOf: url,
                                  encoding: .utf8)
      } catch  {
        txtView.text = nil
        print(error)
      }
    }
  }
  
  // Inhalt des TextViews aus Bundle-Datei laden
  @IBAction func btnReset() {
    if let path = Bundle.main.path(forResource: "defaulttext",
                                   ofType: "txt")
    {
      do {
        txtView.text = try String(contentsOfFile: path,
                                  encoding: .utf8)
      } catch  {
        txtView.text = nil
        print("error")
      }
    }
  }
  
  
  // URL für eine Datei im Document-Verzeichnis
  // der App ermitteln
  func docurl(_ filename:String) -> URL? {
    let fm = FileManager.default
    if let docurl = fm.urls(for: .documentDirectory,
                            in: .userDomainMask).first {
      return docurl.appendingPathComponent(filename)
    } else {
      return nil
    }
  }
}

