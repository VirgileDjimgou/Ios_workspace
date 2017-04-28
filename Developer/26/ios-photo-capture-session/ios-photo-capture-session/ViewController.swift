//
//  ViewController.swift
//  ios-photo-capture-session
//
//  Created by Michael Kofler on 07.10.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

  @IBOutlet weak var previewView: UIView!
  @IBOutlet weak var flashBtn: UIButton!
  
  let captureSession = AVCaptureSession()
  let photoOut = AVCapturePhotoOutput()
  
  var videoInp: AVCaptureDeviceInput!
  var previewLayer: AVCaptureVideoPreviewLayer!
  
  var useRearCamera = true
  var useFlash = false
  
  // hier werden die Fotos gespeichert
  var photos = [UIImage]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Aufnahme-Gerät wählen
    let device: AVCaptureDevice!
    device =
      AVCaptureDevice.defaultDevice(
        withMediaType: AVMediaTypeVideo)
    if device == nil {
      print("Kann nicht auf Kamera zugreifen.")
      exit(EXIT_FAILURE)
    }
    
    // Session mit Kamera-Input verbinden
    videoInp =
      try? AVCaptureDeviceInput(device: device)
    if (captureSession.canAddInput(videoInp)) {
      captureSession.addInput(videoInp)
    } else {
      print("Kann AVCaptureSession nicht einrichten.")
      exit(EXIT_FAILURE)
    }

    // Session mit Photo-Output verbinden
    if captureSession.canAddOutput(photoOut) {
      captureSession.addOutput(photoOut)
    } else {
      print("Kann Output nicht zur CaptureSession hinzufügen.")
      exit(EXIT_FAILURE)
    }

    // Zugriff auf Preview-Layer der Session
    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspect
    previewView.layer.addSublayer(previewLayer)

  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Preview kann nicht in viewDidLoad() eingerichtet
    // werden, weil dort previewView noch nicht positioniert ist
    previewLayer.frame = previewView.bounds
    
    // los geht's
    captureSession.startRunning()
  }
  
  
  // Fotografieren-Button
  @IBAction func takePhoto(_ sender: AnyObject) {
    // Default-Settings
    let settings = AVCapturePhotoSettings()
    
    // Blitz einschalten, wenn die Kamera es erlaubt
    let wantsFlashMode =
      useFlash ? AVCaptureFlashMode.on : AVCaptureFlashMode.off
    if photoOut.supportedFlashModes.contains(
      NSNumber(value: Int(wantsFlashMode.rawValue)))
    {
      settings.flashMode = useFlash ? .on : .off
    }
    
    photoOut.capturePhoto(with: settings, delegate: self)
  }

  // Selfie-Modus ein/aus
  @IBAction func flip(_ sender: AnyObject) {
    useRearCamera = !useRearCamera
    
    let newDevice: AVCaptureDevice!
    if useRearCamera {
      // Default-Kamera
      newDevice =
        AVCaptureDevice.defaultDevice(
          withMediaType: AVMediaTypeVideo)
    } else {
      // Front-Kamera suchen
      let avcdds = AVCaptureDeviceDiscoverySession(
        deviceTypes: [.builtInWideAngleCamera],
        mediaType: AVMediaTypeVideo,
        position: .front)
      if avcdds != nil && avcdds!.devices.count > 0 {
        newDevice = avcdds!.devices.first!
      } else {
        print("Es gibt keine Selfie-Kamera.")
        useRearCamera = true
        return
      }
    }
    
    // vorhandenen Input lösen
    captureSession.removeInput(videoInp)

    // Session mit neuem Kamera-Input verbinden
    videoInp =
      try? AVCaptureDeviceInput(device: newDevice)
    captureSession.addInput(videoInp)
  }
  
  
  // Button zum Ein- und Ausschalten des Blitz
  @IBAction func changeFlash(_ sender: AnyObject) {
    useFlash = !useFlash
    print("Flash = \(useFlash)")
    let imgname = useFlash ? "pho-flash" : "php-flash-off"
    flashBtn.setImage(UIImage(named: imgname), for: .normal)
  }
  
  
  // Fotos anzeigen
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Capture-Session pausieren
    captureSession.stopRunning()
    if let dest = segue.destination as? ImagesVC {
      dest.mainVC = self
    }
  }
  
  // zurück
  @IBAction func unwindToMainVC(_ segue: UIStoryboardSegue) {
    // Live-Vorschau wieder einschalten
    previewLayer.frame = previewView.bounds
    captureSession.startRunning()
  }
  
}


extension ViewController : AVCapturePhotoCaptureDelegate {
  
  // wird aufgerufen, wenn ein Foto gemacht wurde
  func capture(_ captureOutput: AVCapturePhotoOutput,
    didFinishProcessingPhotoSampleBuffer
          photoSampleBuffer: CMSampleBuffer?,
    previewPhotoSampleBuffer: CMSampleBuffer?,
    resolvedSettings: AVCaptureResolvedPhotoSettings,
    bracketSettings: AVCaptureBracketedStillImageSettings?,
    error: Error?)
  {
    if let buffer = photoSampleBuffer,
       let imgData =
          AVCapturePhotoOutput.jpegPhotoDataRepresentation(
            forJPEGSampleBuffer: buffer,
            previewPhotoSampleBuffer: nil),
       let img = UIImage(data: imgData)
    {
      photos.append(img)
    }
  }
}
