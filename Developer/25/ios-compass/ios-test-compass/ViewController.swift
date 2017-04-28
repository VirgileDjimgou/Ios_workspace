//
//  ViewController.swift
//  ios-test-compass
//
//  Created by Michael Kofler on 27.02.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

  // Zugriff auf einen Label und das Compass-View-Steuerelement
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var compass: CompassView!
  
  // Location Manager
  var locmgr: CLLocationManager!

  // Initialisierung
  override func viewDidLoad() {
    super.viewDidLoad()
    

    locmgr = CLLocationManager()
    locmgr.delegate = self
    locmgr.desiredAccuracy = kCLLocationAccuracyBest
    locmgr.startUpdatingHeading()
    
    // auf Drehung des iOS-Geräts reagieren
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(ViewController.rotated),
      name: NSNotification.Name.UIDeviceOrientationDidChange,
      object: nil)
  }

  // Kompassereignis
  func locationManager(_ manager: CLLocationManager,
                       didUpdateHeading newHeading: CLHeading)
  {
    let head = newHeading.trueHeading
    label.text = String(format:"%.1f°", head)
    compass.heading = head
  }
  
  // Kompasskalibrierdialog anzeigen, wenn iOS
  // dies für sinnvoll hält
  func locationManagerShouldDisplayHeadingCalibration(
    _ manager: CLLocationManager) -> Bool
  {
    return true
  }
  
  // Kompass an die Orientierung des Geräts anpassen
  func rotated() {
    switch UIDevice.current.orientation {
    case .portrait:
      locmgr.headingOrientation = .portrait
    case .landscapeLeft:
      locmgr.headingOrientation = .landscapeLeft
    case .landscapeRight:
      locmgr.headingOrientation = .landscapeRight
    case .portraitUpsideDown:
      locmgr.headingOrientation = .portraitUpsideDown
    default: break
    }
  }
  
}

