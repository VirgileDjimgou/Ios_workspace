//
//  ViewController.swift
//  ios-video
//
//  Created by Michael Kofler on 05.10.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

// für kUTType-Konstanten
import MobileCoreServices

// für Web-Viewer (YouTube-Videos)
import SafariServices

class ViewController: UIViewController {
  
  @IBOutlet weak var txtTmp: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // Video aus Internet abspielen
  @IBAction func playVideo(_ sender: AnyObject) {
    // ein NASA-Video von einem Raketenstart
    let url = URL(string: "http://s3.amazonaws.com/akamai.netstorage/HD_downloads/Orion_SM.mp4")!
    let player = AVPlayer(url: url)
    let playerVC = AVPlayerViewController()
    playerVC.player = player
    self.present(playerVC, animated: true) {
      playerVC.player!.play()
    }
    
  }
  
  // YouTube-Seite in Safari-View-Controller anzeigen
  @IBAction func playYouTube(_ sender: AnyObject) {
    // Video2Brain-Video
    let url = URL(string: "https://youtu.be/BQ91R9wutjs")!
    let svc = SFSafariViewController(url: url)
    self.present(svc, animated: true, completion: nil)
  }
  

  // Video aus Medienbibliothek auswählen
  @IBAction func chooseVideo(_ sender: AnyObject) {
    // gibt es überhaupt eine lokale Foto/Video-Sammlung
    if UIImagePickerController
        .isSourceTypeAvailable(.savedPhotosAlbum) == false {
      return
    }
    
    // Image-Picker erzeugen
    let imgPicker = UIImagePickerController()
    imgPicker.sourceType = .savedPhotosAlbum
    imgPicker.mediaTypes = [kUTTypeMovie  as String]
    // imgPicker.allowsEditing = true
    
    // damit didFinishPickingMediaWithInfo-Methode
    // aufgerufen wird
    imgPicker.delegate = self
    
    // Image-Picker anzeigen
    self.present(imgPicker, animated: true, completion: nil)
  }
  
  // neues Video aufnehmen
  @IBAction func recordVideo(_ sender: AnyObject) {
    if UIImagePickerController
         .isSourceTypeAvailable(.camera) == false
    {
      return
    }
    
    let imgPicker = UIImagePickerController()
    imgPicker.sourceType = .camera
    imgPicker.mediaTypes = [kUTTypeMovie as String]
    imgPicker.delegate = self
    present(imgPicker, animated: true, completion: nil)
  }
  
  // Inhalt des temp. Verzeichnisses der App anzeigen
  @IBAction func showTmp(_ sender: AnyObject) {
    txtTmp.text = ""
    let fm = FileManager.default
    let tmp = NSTemporaryDirectory()
    if let files = try? fm.contentsOfDirectory(atPath: tmp) {
      for file in files {  // file hat Datentyp String
        txtTmp.text = txtTmp.text! + file + "\n"
      }
    }
  }

  // Inhalt des temp. Verzeichnisses der App löschen
  @IBAction func deleteTmp(_ sender: AnyObject) {
    let fm = FileManager.default
    let tmp = NSTemporaryDirectory()
    if let files = try? fm.contentsOfDirectory(atPath: tmp) {
      for file in files {  // file hat Datentyp String
        try? fm.removeItem(atPath: tmp + file)
      }
    }
    txtTmp.text = ""
  }
}

// erforderlich für imgPicker.delegate = self
extension ViewController : UIImagePickerControllerDelegate {
  // wird nach abgeschlossener Auswahl aufgerufen
  func imagePickerController(_ picker: UIImagePickerController,
              didFinishPickingMediaWithInfo info: [String : Any])
  {
    let mediaType = info[UIImagePickerControllerMediaType]
                       as! NSString
    dismiss(animated: true) {
      // Closure ausführen, nachdem ImagePicker verschwunden ist
      if mediaType == kUTTypeMovie {
        let url = info[UIImagePickerControllerMediaURL] as! URL
        print(url)
        let player = AVPlayer(url: url)
        let playerVC = AVPlayerViewController()
        playerVC.player = player
        self.present(playerVC, animated: true) {
          playerVC.player!.play()
        }
      }
    }

  }
}

// erforderlich für imgPicker.delegate = self
extension ViewController : UINavigationControllerDelegate {

}
