//
//  ViewController.swift
//  ios-gdc1
//
//  Created by Michael Kofler on 27.09.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  
  @IBOutlet weak var result: UILabel!
  @IBOutlet weak var startBtn: UIButton!
  
  // im Attributinsp. eingestellt: 
  // User Interaction Enabled = off
  // Hides If Stopped = on
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  
  // Queue zur asynchronen Durchführung von Berechnungen
  let myqueue = DispatchQueue(label: "calc-queue")
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func startCalc(_ sender: AnyObject) {
    // synchron
    // result.text = "Ergebnis \(calc())"
    
    print(myqueue.qos)
    
    // ab hier asynchron
    
    // Warten-Anzeige
    spinner.startAnimating()
    
    // Start-Button deaktivieren
    startBtn.isEnabled = false
    
    // Status-Info
    result.text = "Berechnung läuft ..."
    
    // Berechnung asynchron durchführen
    myqueue.async(qos: .userInitiated) {
      let n = self.calc()
      DispatchQueue.main.async {
        self.result.text = "Ergebnis: \(n)"
        self.spinner.stopAnimating()
        self.startBtn.isEnabled = true
      }
    }
  }
  
  
  private func calc() -> Double {
    var result = 0.0
    for i in 1...300_000_000 {
      result += sin(Double(i))
    }
    return result
  }
  
  
}

