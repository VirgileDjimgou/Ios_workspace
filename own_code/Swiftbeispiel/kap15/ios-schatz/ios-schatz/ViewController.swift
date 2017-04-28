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

    // Benachrichtigung von MyLocationManager,
    // wenn sich Position ändern
    NSNotificationCenter.defaultCenter().addObserver(
      self,
      selector: #selector(ViewController.notifyNewLocation(_:)),  // Achtung, Doppelpunkt!
      name: "NewLocation",
      object: nil)
    
    // bei einer Änderung der Gerätausrichtung
    // die Methode rotated() ausführen (nur erforderlich, wenn
    // unterschiedliche Geräte-Ausrichtungen erlaubt sind; das ist
    // bei dieser App nicht der Fall)
    NSNotificationCenter.defaultCenter().addObserver(
      self,
      selector: #selector(ViewController.rotated),
      name: UIDeviceOrientationDidChangeNotification,
      object: nil)
    
    tableView.dataSource = self
  }
  
  // neue Position anzeigen
  func notifyNewLocation(notification:NSNotification) {
    let coord = mylocmgr.location.coordinate
    let long =  degreesMinutes(coord.longitude)
    let lat  =  degreesMinutes(coord.latitude)
    labelPosition.text = "Position Lat = \(lat) / Long = \(long)"
  }
  
  // Geräteausrichtung berücksichtigen (nur erforderlich, wenn
  // unterschiedliche Geräte-Ausrichtungen erlaubt sind; das ist
  // bei dieser App nicht der Fall)
  func rotated() {
    switch UIDevice.currentDevice().orientation {
    case .Portrait:
      mylocmgr.locmgr.headingOrientation = .Portrait
    case .LandscapeLeft:
      mylocmgr.locmgr.headingOrientation = .LandscapeLeft
    case .LandscapeRight:
      mylocmgr.locmgr.headingOrientation = .LandscapeRight
    case .PortraitUpsideDown:
      mylocmgr.locmgr.headingOrientation = .PortraitUpsideDown
    default: break
    }
  }

   
  // Segues
  override func prepareForSegue(segue: UIStoryboardSegue,
                                sender: AnyObject?)
  {
    // Segue zum Popup-Speicherdialog
    if let dest = segue.destinationViewController as? SaveVC,
           popPC = dest.popoverPresentationController
    {
      popPC.delegate = self
    }
    // Segue zur Detailansicht
    if let dest = segue.destinationViewController as? DetailVC ,
           cell = sender as? UITableViewCell,
           indexPath = tableView.indexPathForCell(cell)
    {
      dest.row = indexPath.row
      dest.pos = poslist[indexPath.row]
      dest.delegate = self
    }
  }

  // unwind vom Speicher-Dialog, neuen Punkt speichern
  @IBAction func unwindToMainView(segue: UIStoryboardSegue) {
    if let src = segue.sourceViewController as? SaveVC {
      // explizit ausblenden, siehe
      // http://stackoverflow.com/questions/28247727/
      if !segue.sourceViewController.isBeingDismissed() {
        segue.sourceViewController
          .dismissViewControllerAnimated(true, completion: nil)
      }
      if let txt = src.posname.text {
        let posname = txt.stringByTrimmingCharactersInSet(
          NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if posname != "", let loc = mylocmgr.location {
          let newpos =
            Position(posname,
                     loc.timestamp,
                     loc.coordinate.latitude,
                     loc.coordinate.longitude)
          // am Beginn der Liste einfügen
          poslist.insert(newpos, atIndex: 0)
          // neue Liste bleibend speichern
          Position.saveArrayToFile(poslist)
          // anzeigen
          tableView.reloadData()
        }
      }
    }
  }
}

// eigener Delegate zur Verarbeitung der Rückkehr von DetailVC
extension ViewController: DetailVCDelegate {
  func backFromDetailVC(sourceVC: DetailVC) {
    if sourceVC.deleteItem == true {
      // Listenelement löschen
      poslist.removeAtIndex(sourceVC.row)
      // anzeigen
      tableView.reloadData()
      // geänderte Liste bleibend speichern
      Position.saveArrayToFile(poslist)
    } else {
      // gegebenenfalls Titel des Listenelements ändern
      let txt = sourceVC.txtPosition.text!
      let newname = txt.stringByTrimmingCharactersInSet(
        NSCharacterSet.whitespaceAndNewlineCharacterSet())
      if newname != "" && newname != poslist[sourceVC.row].name {
        poslist[sourceVC.row].name = newname
        Position.saveArrayToFile(poslist)
        tableView.reloadData()
      }

    }
  }
}

// erforderlich für Popover-Dialog
extension ViewController: UIPopoverPresentationControllerDelegate {
  func adaptivePresentationStyleForPresentationController(
    controller: UIPresentationController) -> UIModalPresentationStyle
  {
    return .None
  }
}

// DataSource-Methoden
extension ViewController: UITableViewDataSource {
  // gibt die Anzahl der Abschnitte der Liste an
  func numberOfSectionsInTableView(tableView: UITableView) -> Int
  {
    return 1
  }
  
  // gibt die Anzahl der Listenelemente an
  func tableView(tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int
  {
    return poslist.count
  }
  
  // liefert Tabellenzellen zur Darstellung im Steuerelement
  func tableView(tableView: UITableView,
          cellForRowAtIndexPath indexPath: NSIndexPath)
    -> UITableViewCell
  {
    let dfmt = NSDateFormatter()
    dfmt.dateStyle = .MediumStyle
    dfmt.timeStyle = .ShortStyle
    let cell = tableView.dequeueReusableCellWithIdentifier(
      "ProtoCell", forIndexPath: indexPath) 
    let row = indexPath.row
    cell.textLabel?.text = poslist[row].name
    cell.detailTextLabel?.text = dfmt.stringFromDate(poslist[row].time)
    return cell
  }
}

