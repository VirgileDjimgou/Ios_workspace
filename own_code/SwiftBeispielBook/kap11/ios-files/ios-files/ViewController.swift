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
  
  override func viewDidLoad() {
    txtView.layer.borderColor = UIColor.lightGrayColor().CGColor
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
    if let path = docpath("data.txt") {
      do {
        try txtView.text.writeToFile(path,
          atomically: false,
          encoding: NSUTF8StringEncoding)
      } catch  {
        print(error)
      }
    }
  }
  
  // Inhalt des TextViews aus Document-Datei laden
  @IBAction func btnLoad() {
    if let path = docpath("data.txt") {
      do {
        txtView.text = try String(contentsOfFile: path,
          encoding: NSUTF8StringEncoding)
      } catch  {
        txtView.text = nil
        print(error)
      }
    }
  }
  
  // Inhalt des TextViews aus Bundle-Datei laden
  @IBAction func btnReset() {
    if let path = NSBundle.mainBundle().pathForResource("defaulttext", ofType: "txt") {
      do {
        txtView.text = try String(contentsOfFile: path,
          encoding: NSUTF8StringEncoding)
      } catch  {
        txtView.text = nil
        print(error)
      }
    }
  }
  
  
  // Pfad zu einer Datei im Document-Verzeichnis
  // der App ermitteln
  func docpath(filename:String) -> String? {
    let pfd =     // Datentyp [AnyObject]!
      NSSearchPathForDirectoriesInDomains(
        .DocumentDirectory, .UserDomainMask, true)
    if let path = pfd.first {
      return path + "/" + filename
    } else {
      return nil
    }
  }
}

