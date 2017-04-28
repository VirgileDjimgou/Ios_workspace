//
//  ViewController.swift
//  ios-async-image
//
//  Created by Michael Kofler on 06.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var imgview: UIImageView!
  @IBOutlet weak var progress: UIProgressView!
  
  
  lazy var uSession: URLSession = {
    // Closure, liefert Session-Objekt
    // erst bei Bedarf zurück
    let config = URLSessionConfiguration.default
    return URLSession(configuration: config,
                      delegate: self,
                      delegateQueue: nil)
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // asynchronen Download starten
    let url =
      URL(string: "https://kofler.info/uploads/lugauer.jpg")!
    let uTask = uSession.downloadTask(with: url)
    uTask.resume()  // Download starten
    
    // Variante: Bild einfach statisch laden
    //    print("xxx \(Date())")
    //    let url = URL(string: "https://kofler.info/uploads/lugauer.jpg")!
    //    do {
    //      let bindata = try Data(contentsOf: url)
    //      imgview.image = UIImage(data: bindata)
    //    } catch {
    //      print(error.localizedDescription)
    //    }
    //    print("xxx \(Date())")
  }

  // Hintergrundfarbe ändern
  @IBAction func colorButton(_ sender: UIButton) {
    let title = sender.titleLabel!.text!
    switch title {
    case "Rot":
      self.view.backgroundColor = .red
    case "Grün":
      self.view.backgroundColor = .green
    case "Blau":
      self.view.backgroundColor = .blue
    default:
      break  // sollte nicht vorkommen
      
    }
  }
  
}

// URLSession-spezifischer Code
extension ViewController : URLSessionDownloadDelegate {

  // Download abgeschlossen
  func urlSession(_ session: URLSession,
                  downloadTask _: URLSessionDownloadTask,
                  didFinishDownloadingTo loc: URL)
  {
    // Bild aus Cache-Verzeichnis laden
    // zweifaches Optional, einmal wegen try?, 
    // einmal wegen UIImage; if let gilt nur für try?
    // der wahrscheinlichste Fall, dass UIImage scheitert, ist
    // der Download einer 404-Seite anstelle des Bilds
    if let img = try? UIImage(data: Data(contentsOf: loc)),
       img != nil
    {
      setProgressAndImage(progress: 0, image: img)
    } else {
      print("xxx image load/convert failed")
      setFailedImage()
    }
  }

  // Download schreitet voran
  func urlSession(_ session: URLSession,
                  downloadTask: URLSessionDownloadTask,
                  didWriteData bytesWritten: Int64,
                  totalBytesWritten: Int64,
                  totalBytesExpectedToWrite: Int64)
  {
    let prg = Float(totalBytesWritten) /
              Float(totalBytesExpectedToWrite)
    print("xxx Progress = \(prg)")
    if prg > 0 {
      setProgressAndImage(progress: prg)
    }
  }
  
  // Download gescheitert; wird seltsamerweise auch aufgerufen,
  // wenn alles OK, dann gilt error == nil
  func urlSession(_ session: URLSession,
                  task: URLSessionTask,
                  didCompleteWithError usError: Error?)
  {
    print("xxx completeWithError = \(usError)")
    if usError == nil { return }
    setFailedImage()
  }
  


  // Image und Progressbar im Main-Thread ändern
  private func setProgressAndImage(progress: Float,
                                   image: UIImage? = nil)
  {
    DispatchQueue.main.async { // closure
      self.progress.progress = progress
      if image != nil {
        self.imgview.image = image
        self.imgview.contentMode = .scaleAspectFill
      }
    }
  }
  private func setFailedImage() {
    DispatchQueue.main.async { // closure
      self.progress.progress = 0
      self.imgview.image = UIImage(named: "fil-warning")
      self.imgview.contentMode = .center
    }
  }
  

}
