//
//  CalcVC.swift
//  ios-currency-calculator
//
//  Created by Michael Kofler on 06.04.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class CalcVC: UIViewController {
  // Label für Währung 1/2
  @IBOutlet weak var lbl1: UILabel!
  @IBOutlet weak var lbl2: UILabel!
  
  // Eingabefeld für Währung 1/2
  @IBOutlet weak var txt1: UITextField!
  @IBOutlet weak var txt2: UITextField!

  // Flagge für Währung 1/2
  @IBOutlet weak var img1: UIImageView!
  @IBOutlet weak var img2: UIImageView!
  
  // Label für Kursinfo
  @IBOutlet weak var lblDate: UILabel!
  
  // Zugriff auf User Defaults
  let userdef = UserDefaults.standard
  
  // zur Formatierung von Zahlen
  let formatter = NumberFormatter()

  // Calculator (Data Model)
  var cc: CurCalc!
  
  // die zwei aktiven Währungen
  var cur1 = "EUR" {
    // bei jeder Änderung: bleibend speichern,
    // Label aktualisieren, Textfelder löschen
    didSet {
      lbl1?.text = cur1
      img1?.image =
        UIImage(named: CurCalc.getCountryFromCurrency(cur1))
      txt1?.text = ""
      txt2?.text = ""
      userdef.set(cur1, forKey: "currency1")
    }
  }
  var cur2 = "USD" {
    didSet {
      lbl2?.text = cur2
      img2?.image =
        UIImage(named: CurCalc.getCountryFromCurrency(cur2))
      txt1?.text = ""
      txt2?.text = ""
      userdef.set(cur2, forKey: "currency2")
    }
  }
  
  // Initialisierung
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Formatter-Eigenschaften
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 0
    formatter.groupingSeparator = "\u{2006}"  // kleiner Abstand
    formatter.usesGroupingSeparator = true
    
    // Kurse laden
    refreshData()
    
    // wenn schon in Xcode eingestellt, dann lässt
    // sich dort Höhe nicht einstellen
    txt1.borderStyle = .roundedRect
    txt2.borderStyle = .roundedRect
    
    // zuletzt gültige Währungen aus den User Defaults lesen
    cur1 = userdef.string(forKey: "currency1") ?? "EUR"
    cur2 = userdef.string(forKey: "currency2") ?? "USD"
    
    // Gesture Recognizer für Tap auf View
    let tapGR = UITapGestureRecognizer(target: self,
      action: #selector(CalcVC.handleTap(_:)))
    tapGR.delegate = self
    view.addGestureRecognizer(tapGR)

    // Delegates für UITextField
    txt1.delegate = self
    txt2.delegate = self
  }


  // refresh-Button
  @IBAction func refresh(_ sender: UIButton) {
    refreshData()
  }
  
  // ECB-Kurse laden
  func refreshData() {
    txt1.text = ""
    txt2.text = ""
    cc = CurCalc()
    
    // Zeichenketten mit Datum der Kurse vorbereiten
    let msg1 = NSLocalizedString("Kurse vom %@",
      comment: "zeigt das Datum der Kurse an")
    let msg2 = NSLocalizedString("Keine aktuellen Kurse verfügbar!",
      comment: "wird angezeigt, wenn die Kurse älter als sechs Tage sind oder wenn gar keine Kurse verfügbar sind")
    let dateformatter = DateFormatter()
    dateformatter.dateStyle = .medium
    dateformatter.timeStyle = .none
    let formattedDate = dateformatter.string(from: cc.lastupdate as Date)
    lblDate.text = String(format: msg1, formattedDate)
    
    // Kursinfo grün/gelb/rot anzeigen
    let daysSinceUpdate = -cc.lastupdate.timeIntervalSinceNow / (60*60*24.0)
    if daysSinceUpdate<3 {
      lblDate.textColor =
        UIColor(red:0.0, green:0.7, blue:0.0, alpha:1.0)
    } else if daysSinceUpdate < 6 {
      lblDate.textColor =
        UIColor(red:0.5, green:0.4, blue:0.0, alpha:1.0)
    } else {
      lblDate.text = msg2
      lblDate.textColor =
        UIColor(red:0.7, green:0.0, blue:0.0, alpha:1.0)
    }
  }

  
  // wird bei durch den Benutzer (nicht durch Code) 
  // ausgelösten Änderungen des Textfelds aufgerufen
  @IBAction func txtEditingChanged(_ sender: UITextField) {
    var value:Double
    if let decimal = formatter.number(from: sender.text!) {
      value = Double(decimal)
    } else {
      value = 0.0
    }
    if sender === txt1 {
      // Umrechnung in Währung zwei
      txt2.text = formatter.string(
        from: NSNumber(value: cc.convert(value,
                                         from:cur1,
                                         to: cur2)))
    } else if sender === txt2 {
      // Umrechnung in Währung eins
      txt1.text = formatter.string(
        from: NSNumber(value: cc.convert(value,
                                         from:cur2,
                                         to: cur1)))
    }
  }

}

// Fingerdruck auf den Hintergrund (also auf den View)
// blendet die Tastatur aus
extension CalcVC: UIGestureRecognizerDelegate {
  func handleTap(_ gesture: UITapGestureRecognizer) {
    view.endEditing(true)
  }
}

// verhindern, dass zwei Kommas eingegeben werden
extension CalcVC: UITextFieldDelegate {
  func textField(_ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString input: String) -> Bool
  {
    
    if let old = textField.text,
       let sep = formatter.decimalSeparator
    {
      // keine Eingabe von zwei Kommas/Dezimalpunkten
      if input == sep && old.range(of: sep) != nil {
        return false
      }
      // nicht mehr als 9 Zeichen (aber Backspace erlauben)
      if input != "" && old.characters.count>9 {
        return false
      }
    }
    return true
  }
  
}







































