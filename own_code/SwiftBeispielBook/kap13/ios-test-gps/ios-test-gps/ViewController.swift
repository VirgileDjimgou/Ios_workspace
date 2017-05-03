//
//  ViewController.swift
//  ios-test-gps
//
//  Created by Michael Kofler on 25.02.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
  
  @IBOutlet weak var map: MKMapView!
  @IBOutlet weak var label: UILabel!
  
  var locmgr:CLLocationManager!
  var coords:[CLLocationCoordinate2D] = []     // Array für die Positionen
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Location Manager initialisieren
    locmgr = CLLocationManager()
    locmgr.delegate = self
    locmgr.desiredAccuracy = kCLLocationAccuracyBest
    locmgr.requestAlwaysAuthorization()
    locmgr.startUpdatingLocation()
    
    // Map-Methoden verarbeiten
    map.delegate = self
  }
  
  // wird einmal pro Sekunde aufgerufen, um die aktuelle Position
  // mitzuteilen
  func locationManager(manager:CLLocationManager,
    didUpdateLocations locations:[CLLocation])
  {
    for loc in locations {
      // Position anzeigen und dem coords-Array hinzufügen
      let long =   String(format: "%.4f", loc.coordinate.longitude)
      let lat  =   String(format: "%.4f", loc.coordinate.latitude)
      let alt =    String(format: "%.1f", loc.altitude)
      let speed =  String(format: "%.1f", loc.speed)
      let course = String(format: "%.1f", loc.course)
      label.text = "long= \(long)° / lat = \(lat)° \n" +
        "alt = \(alt) m \n" +
        "speed = \(speed) m/s \n" +
        "course = \(course)° \n" +
        "time = \(loc.timestamp) \n"
      
      // sichtbaren Bereich der Karte (inkl. Zoom) einstellen
      // aktuelle Position immer zentriert
      let span = 0.01  // in Grad; 1° entspricht 111 km, 0.01° entspricht 1100 m
      let reg = MKCoordinateRegion(
        center: map.userLocation.coordinate,
        span: MKCoordinateSpanMake(span, span))
      map.setRegion(reg, animated: false)
      
      // Koordinaten speichern
      coords.append(loc.coordinate)
      
      // fügt dem Map-Overlay eine Linie vom letzten
      // zum vorletzten Punkt hinzu
      let n = coords.count
      if n > 4 {  // die ersten Messpunkte ignorieren, oft ungenau
        var pts = [coords[n-1], coords[n-2]]
        let polyline =
        MKPolyline(coordinates: &pts, count: pts.count)
        map.addOverlay(polyline)
      }
    }
  }
  

  
  // wird einmal pro Sekunde aufgerufen, bietet die
  // Möglichkeit, ein Renderer-Objekt zum Zeichnen
  // des Overlay anzugeben (TODO)
  func mapView(mapView: MKMapView,
               rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer
  {
    if overlay is MKPolyline {
      let polylineRenderer = MKPolylineRenderer(overlay: overlay)
      polylineRenderer.strokeColor = UIColor.redColor()
      polylineRenderer.lineWidth = 3
      return polylineRenderer
    } else {
      // leere MKOverlayRenderer-Instanz zurückgeben
      return MKOverlayRenderer()
    }
  }


}

