//
//  MyLocationManager.swift
//  ios-schatz
//
//  Created by Michael Kofler on 19.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import CoreLocation

// Ableitung von NSObject ist erforderlich, weil sonst Fehler
// 'does not conform to protocol NSObjectProtocol'
class MyLocationManager : NSObject, CLLocationManagerDelegate {
  // Singleton-Muster, Zugriff auf gemeinsame
  // Instanz von MyLocationManager
  static let sharedInstance = MyLocationManager()

  // intern: Referenz auf den Location Manager
  var locmgr = CLLocationManager()
  
  // bequemer Zugriff auf die letzte Position
  // enthält Daten, sobald locationManager das
  // erste Mal aufgerufen wurde
  var location:CLLocation!
  var heading:CLHeading!
  
  // Location Manager initialisieren
  override init () {
    super.init()
    locmgr.delegate = self
    locmgr.desiredAccuracy = kCLLocationAccuracyBest
    locmgr.requestWhenInUseAuthorization()
    locmgr.startUpdatingLocation()
    locmgr.startUpdatingHeading()
  }

  
  // didUpdateLocation-Delegation verarbeiten
  func locationManager(_ manager: CLLocationManager,
                       didUpdateLocations locations: [CLLocation])
  {
    location = locmgr.location
    NotificationCenter.default.post(
      name: Notification.Name(rawValue: "NewLocation"),
      object: manager)
  }

  // didUpdateLocation-Delegation verarbeiten
  func locationManager(_ manager: CLLocationManager,
    didUpdateHeading newHeading: CLHeading)
  {
    heading = locmgr.heading
    NotificationCenter.default.post(
      name: Notification.Name(rawValue: "NewHeading"),
      object: manager)
  }

  // bei Bedarf Dialog zur Kompasskalibrierung einblenden
  func locationManagerShouldDisplayHeadingCalibration(
    _ manager: CLLocationManager) -> Bool
  {
    return true
  }
  
}
