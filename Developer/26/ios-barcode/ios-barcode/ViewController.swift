//
//  ViewController.swift
//  ios-barcode
//
//  Created by Michael Kofler on 11.10.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

// Quellen: 
// https://www.hackingwithswift.com/example-code/media/how-to-scan-a-barcode
// http://stackoverflow.com/questions/31170750

import UIKit
import AVFoundation

class ViewController: UIViewController,
                      AVCaptureMetadataOutputObjectsDelegate
{
  @IBOutlet weak var statusLbl: UILabel!
  @IBOutlet weak var previewView: UIView!
  @IBOutlet weak var startBtn: UIButton!

  var captureSession = AVCaptureSession()
  var previewLayer: AVCaptureVideoPreviewLayer!
  
  // Initialisierungsarbeiten
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Aufnahme-Gerät wählen
    let device: AVCaptureDevice!
    device =
      AVCaptureDevice.defaultDevice(
        withMediaType: AVMediaTypeVideo)
    if device == nil { exit(EXIT_FAILURE) }
    
    // Auto-Fokus konfigurieren, bringt nicht viel
    // http://stackoverflow.com/questions/5391203
    do {
      try device.lockForConfiguration()
      // Bildmitte
      device.focusPointOfInterest = CGPoint(x: 0.5, y: 0.5)
      // Macro-Modus
      device.autoFocusRangeRestriction = .near
      // Auto-Fokus ständig aktualisieren
      device.focusMode = .continuousAutoFocus
      device.unlockForConfiguration()
    } catch {
      print("Kann Fokus nicht einstellen.")
    }
    
    
    let videoInput =
      try? AVCaptureDeviceInput(device: device)
    
    if (captureSession.canAddInput(videoInput)) {
      captureSession.addInput(videoInput)
    } else {
      print("Kann AVCaptureSession nicht einrichten.")
      exit(EXIT_FAILURE)
    }
    
    // Barcode erkennen versuchen, bei Erfolg
    // delegate-Methode im Main-Queue aufrufen
    let metadataOutput = AVCaptureMetadataOutput()
    if captureSession.canAddOutput(metadataOutput) {
      captureSession.addOutput(metadataOutput)
      metadataOutput.metadataObjectTypes =
        [AVMetadataObjectTypeEAN8Code,
         AVMetadataObjectTypeEAN13Code,
         AVMetadataObjectTypePDF417Code]
      metadataOutput.setMetadataObjectsDelegate(
        self, queue: DispatchQueue.main)
    } else {
      print("Barcode-Scanner kann nicht eingerichtet werden")
      exit(EXIT_FAILURE)
    }
    
    // Preview kann nicht in viewDidLoad() eingerichtet
    // werden, weil dort previewView noch nicht positioniert ist
    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
    previewView.layer.addSublayer(previewLayer)
    
  }
  
  // Bilderkennung starten
  override func viewDidAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    previewLayer.frame = previewView.bounds
    captureSession.startRunning()
  }
  
  
  // nur zweckmäßig, wenn es mehrere Seiten gibt
  
  //  override func viewWillDisappear(_ animated: Bool) {
  //    super.viewWillDisappear(animated)
  //
  //    if (captureSession.isRunning == true) {
  //      captureSession.stopRunning()
  //    }
  //  }
  
  // Start-Button
  @IBAction func startScanner(_ sender: AnyObject) {
    captureSession.startRunning()
    startBtn.isEnabled = false
  }
  
  // AVCaptureMetadataOutputObjectsDelegate-Delegate
  func captureOutput(_ captureOutput: AVCaptureOutput!,
                     didOutputMetadataObjects metadataObjects: [Any]!,
                     from connection: AVCaptureConnection!)
  {
    
    // iOS kann mehrere Objekte gleichzeitig erkennen
    // die Schleife berücksichtigt nur das erste
    for metaObj in  metadataObjects {
      print("x")
      if let readableObject = metaObj
                as? AVMetadataMachineReadableCodeObject,
         let bcode = readableObject.stringValue
      {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        statusLbl.text = bcode
        // Bild-Updates stoppen, aber das zuletzt sichtbare Bild
        // bleibt
        captureSession.stopRunning()
        // Button für neuerliches Scannen
        startBtn.isEnabled = true
        break
      }
    }
  }
 
}

