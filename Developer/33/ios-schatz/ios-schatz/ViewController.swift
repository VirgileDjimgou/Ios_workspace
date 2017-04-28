//
//  ViewController.swift
//  ios-schatz
//
//  Created by Michael Kofler on 18.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
  
  @IBOutlet weak var labelPosition: UILabel!
  @IBOutlet weak var tableView: UITableView!
  
  let mylocmgr = MyLocationManager.sharedInstance
  var poslist = Position.readArrayFromFile()

  override func viewDidLoad() {
    super.viewDidLoad()
    // testDegrees()

    // Benachrichtigung von MyLocationManager,
    // wenn sich Position ändern
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(ViewController.notifyNewLocation(_:)),
      name: Notification.Name(rawValue: "NewLocation"),
      object: nil)
    
    // bei einer Änderung der Gerätausrichtung
    // die Methode rotated() ausführen (nur erforderlich, wenn
    // unterschiedliche Geräte-Ausrichtungen erlaubt sind; das ist
    // bei dieser App nicht der Fall)
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(ViewController.rotated),
      name: Notification.Name.UIDeviceOrientationDidChange,
      object: nil)
    
    tableView.dataSource = self
    
    let udir = FileManager.default.urls(for: .userDirectory, in: .userDomainMask).first
    print("xxx \(udir)")
  }
  
  // neue Position anzeigen
  func notifyNewLocation(_ notification: Notification) {
    let coord = mylocmgr.location.coordinate
    let long =  degreesMinutes(coord.longitude)
    let lat  =  degreesMinutes(coord.latitude)
    labelPosition.text = "Position Lat = \(lat) / Long = \(long)"
  }
  
  // Geräteausrichtung berücksichtigen (nur erforderlich, wenn
  // unterschiedliche Geräte-Ausrichtungen erlaubt sind; das ist
  // bei dieser App nicht der Fall)
  func rotated() {
    switch UIDevice.current.orientation {
    case .portrait:
      mylocmgr.locmgr.headingOrientation = .portrait
    case .landscapeLeft:
      mylocmgr.locmgr.headingOrientation = .landscapeLeft
    case .landscapeRight:
      mylocmgr.locmgr.headingOrientation = .landscapeRight
    case .portraitUpsideDown:
      mylocmgr.locmgr.headingOrientation = .portraitUpsideDown
    default: break
    }
  }

   
  // Segues
  override func prepare(for segue: UIStoryboardSegue,
                        sender: Any?)
  {
    // Segue zum Popup-Speicherdialog
    if let dest = segue.destination as? SaveVC,
       let popPC = dest.popoverPresentationController
    {
      popPC.delegate = self
    }
    // Segue zur Detailansicht
    if let dest = segue.destination as? DetailVC ,
       let cell = sender as? UITableViewCell,
       let indexPath = tableView.indexPath(for: cell)
    {
      dest.row = indexPath.row
      dest.pos = poslist[indexPath.row]
      dest.delegate = self
    }
  }

  // unwind vom Speicher-Dialog, neuen Punkt speichern
  @IBAction func unwindToMainView(_ segue: UIStoryboardSegue) {
    if let src = segue.source as? SaveVC {
      // explizit ausblenden, siehe
      // http://stackoverflow.com/questions/28247727/
      if !segue.source.isBeingDismissed {
        segue.source.dismiss(animated: true, completion: nil)
      }
      if let txt = src.posname.text {
        let posname = txt.trimmingCharacters(
          in: CharacterSet.whitespacesAndNewlines)
        if posname != "", let loc = mylocmgr.location {
          let newpos =
            Position(posname,
                     loc.timestamp,
                     loc.coordinate.latitude,
                     loc.coordinate.longitude)
          // am Beginn der Liste einfügen
          poslist.insert(newpos, at: 0)
          // neue Liste bleibend speichern
          Position.saveArrayToFile(poslist)
          // anzeigen
          tableView.reloadData()
        }
      }
    }   // Ende if-let-Konstruktion
  }     // Ende unwind-Methode
}       // Ende class

// eigener Delegate zur Verarbeitung der Rückkehr von DetailVC
extension ViewController: DetailVCDelegate {
  func backFromDetailVC(_ sourceVC: DetailVC) {
    if sourceVC.deleteItem == true {
      // Listenelement löschen
      poslist.remove(at: sourceVC.row)
      // anzeigen
      tableView.reloadData()
      // geänderte Liste bleibend speichern
      Position.saveArrayToFile(poslist)
    } else {
      // gegebenenfalls Titel des Listenelements ändern
      let txt = sourceVC.txtPosition.text!
      let newname = txt.trimmingCharacters(
        in: CharacterSet.whitespacesAndNewlines)
      if newname != "" && newname != poslist[sourceVC.row].name {
        poslist[sourceVC.row].name = newname
        Position.saveArrayToFile(poslist)
        tableView.reloadData()
      }

    }   // Ende if-else-Konstruktion
  }     // Ende back-Methode
}       // Ende extension

// erforderlich für Popover-Dialog
extension ViewController :
          UIPopoverPresentationControllerDelegate
{
  func adaptivePresentationStyle(
         for controller: UIPresentationController)
    -> UIModalPresentationStyle
  {
    return .none
  }
}

// DataSource-Methoden
extension ViewController: UITableViewDataSource {
  // gibt die Anzahl der Abschnitte der Liste an
  func numberOfSections(in tableView: UITableView) -> Int
  {
    return 1
  }
  
  // gibt die Anzahl der Listenelemente an
  func tableView(_ tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int
  {
    return poslist.count
  }
  
  // liefert Tabellenzellen zur Darstellung im Steuerelement
  func tableView(_ tableView: UITableView,
          cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
  {
    let dfmt = DateFormatter()
    dfmt.dateStyle = .medium
    dfmt.timeStyle = .short
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "ProtoCell", for: indexPath) 
    cell.textLabel?.text = poslist[indexPath.row].name
    cell.detailTextLabel?.text =
      dfmt.string(from: poslist[indexPath.row].time as Date)
    return cell
  }
}

