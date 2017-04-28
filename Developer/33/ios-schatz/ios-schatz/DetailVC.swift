//
//  DetailVC.swift
//  ios-schatz
//
//  Created by Michael Kofler on 19.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit
import CoreLocation

// Detail-Dialog für Positionsdaten
protocol DetailVCDelegate {
  func backFromDetailVC(_ sourceVC: DetailVC)
}

class DetailVC: UIViewController {
  
  var pos:Position!      // Positions-Instanz
  var row:Int!           // Index für listpos-Array
  let mylocmgr = MyLocationManager.sharedInstance
  var deleteItem = false // den aktuellen Listeneintrag löschen
  var heading = 0.0      // Richtung zum Ziel (0 bis 360 Grad)
  var delegate:DetailVCDelegate?  // close-Benachrichtigung
  
  @IBOutlet weak var txtPosition: UITextField!
  @IBOutlet weak var lblTime: UILabel!
  @IBOutlet weak var lblLatLong: UILabel!
  @IBOutlet weak var lblDistance: UILabel!
  @IBOutlet weak var arrowview: ArrowView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if pos == nil { return }
    
    // Steuerelemente mit Daten aus 'pos' initilisieren
    let dfmt = DateFormatter()
    dfmt.dateStyle = .medium
    dfmt.timeStyle = .short
    txtPosition.text = pos.name
    lblTime.text = "Zeit: " + dfmt.string(from: pos.time as Date)
    let long =   degreesMinutes(pos.long)
    let lat  =   degreesMinutes(pos.lat)
    lblLatLong.text = "Ort: Lat = \(lat) / Long = \(long)"
    
    // Tastaturereignisse verarbeiten
    txtPosition.delegate = self

    // neue Position verarbeiten
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(DetailVC.notifyNewLocation(_:)),  // Achtung, Doppelpunkt!
      name: Notification.Name(rawValue: "NewLocation"),
      object: nil)
    
    // neue Kompassrichtung verarbeiten
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(DetailVC.notifyNewHeading(_:)),  // Achtung, Doppelpunkt!
      name: Notification.Name(rawValue: "NewHeading"),
      object: nil)
  }
  
  // Benachrichtigung über neue Position
  func notifyNewLocation(_ notification:Notification) {
    // Entfernung zwischen 'pos' und aktuellem Standpunkt errechnen
    let loc = CLLocation(latitude: pos.lat, longitude: pos.long)
    let dist = mylocmgr.location.distance(from: loc)
    lblDistance.text = "⇥ " + String(format: "%.0f m", dist)
    
    // Richtung vom Standpunkt zum Ziel berechnen
    // http://stackoverflow.com/questions/3809337
    let toLat  =   pos.lat / 180 * .pi
    let toLong =   pos.long / 180 * .pi
    let fromLat =
      mylocmgr.location.coordinate.latitude / 180 * .pi
    let fromLong =
      mylocmgr.location.coordinate.longitude / 180 * .pi
    let rad = atan2(sin(toLong - fromLong) * cos(toLat),
                    cos(fromLat) * sin(toLat) -
                    sin(fromLat) * cos(toLat) *
                    cos(toLong - fromLong))
    heading = rad * 180 / .pi
  }

  // Benachrichtigung über neue Kompassrichtung
  func notifyNewHeading(_ notification:Notification) {
    // Richtung von der aktuellen Richtung zum Ziel ausrechnen
    arrowview.heading =
      mylocmgr.heading.trueHeading - heading + 90
  }

  
  // 'Eintrag Löschen'-Button
  @IBAction func deleteBtn(_ sender: UIButton) {
    // Dialog zusammenstellen
    let alert = UIAlertController(
       title: "Eintrag löschen",
       message: "Den Eintrag wirklich löschen?",
       preferredStyle: .alert)
    
    // 'ja': deleteItem auf true setzen, dann Popup schließen
    alert.addAction(
      UIAlertAction(title: "Ja", style: .destructive, handler:
        { (_) in self.deleteItem = true
          _ = self.navigationController?
                .popViewController(animated: true)
          
        }
      ))

    // 'nein': keine Reaktion
    alert.addAction(
      UIAlertAction(title: "Nein", style: .cancel, handler:nil))
    
    
    // Dialog anzeigen
    present(alert, animated: true, completion: nil)
  }
  
  // beim Ausblenden des Dialogs Delegate-Methode aufrufen
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    delegate?.backFromDetailVC(self)
  }
  
}

extension DetailVC : UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // Eingabe beenden, Tastatur ausblenden
    view.endEditing(true)
    // Popup schließen
    _ = navigationController?.popViewController(animated: true)
    // 'Return' nicht als Eingabe weitergeben
    return false
  }
}
