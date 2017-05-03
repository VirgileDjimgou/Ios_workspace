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

  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var compass: CompassView!
  
  var locmgr:CLLocationManager!

  // Initialisierung
  override func viewDidLoad() {
    super.viewDidLoad()
    locmgr = CLLocationManager()
    locmgr.delegate = self
    locmgr.desiredAccuracy = kCLLocationAccuracyBest
    locmgr.startUpdatingHeading()
    
    // auf Drehung des iOS-Geräts reagieren
    NSNotificationCenter.defaultCenter().addObserver(
      self,
      selector: #selector(ViewController.rotated),
      name: UIDeviceOrientationDidChangeNotification,
      object: nil)
  }

  // Kompassereignis
  func locationManager(manager: CLLocationManager,
                       didUpdateHeading newHeading: CLHeading)
  {
    let head = newHeading.trueHeading
    label.text = String(format:"%.1f°", head)
    compass.heading = head
  }
  
  // Kompasskalibrierdialog anzeigen, wenn iOS
  // dies für sinnvoll hält
  func locationManagerShouldDisplayHeadingCalibration(
    manager: CLLocationManager) -> Bool
  {
    return true
  }
  
  // Kompass an die Orientierung des Geräts anpassen
  func rotated() {
    switch UIDevice.currentDevice().orientation {
    case .Portrait           : locmgr.headingOrientation = .Portrait
    case .LandscapeLeft      : locmgr.headingOrientation = .LandscapeLeft
    case .LandscapeRight     : locmgr.headingOrientation = .LandscapeRight
    case .PortraitUpsideDown : locmgr.headingOrientation = .PortraitUpsideDown
    default: break
    }
  }
  
}

