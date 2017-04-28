//
//  ViewController.swift
//  ios-photo
//
//  Created by Michael Kofler on 07.10.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit
import MobileCoreServices  // für kUTType-Konstanten

class ViewController: UIViewController {

  @IBOutlet weak var img: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func choosePhoto(_ sender: AnyObject) {
    // gibt es überhaupt eine lokale Foto/Video-Sammlung?
    if UIImagePickerController
      .isSourceTypeAvailable(.savedPhotosAlbum) == false {
      return
    }
    
    // Image-Picker erzeugen
    let imgPicker = UIImagePickerController()
    imgPicker.sourceType = .photoLibrary  // alle Bilder
    // imgPicker.sourceType = .savedPhotosAlbum  // nur selbst aufgenommene Bilder
    
    // damit Reaktion auf Auswahl möglich ist
    imgPicker.delegate = self
    
    // Image-Picker anzeigen
    self.present(imgPicker, animated: true, completion: nil)
  }
  
  @IBAction func takePhoto(_ sender: AnyObject) {
    let imgPicker = UIImagePickerController()
    imgPicker.sourceType = .camera
    imgPicker.cameraDevice = .rear
    imgPicker.delegate = self
    self.present(imgPicker, animated: true, completion: nil)
  }
  
}

extension ViewController : UIImagePickerControllerDelegate,
  UINavigationControllerDelegate
{
  // wird nach abgeschlossener Auswahl aufgerufen
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [String : Any])
  {
    let mediaType =
      info[UIImagePickerControllerMediaType] as! NSString
    if mediaType == kUTTypeImage {
      self.img.image =
        (info[UIImagePickerControllerOriginalImage] as! UIImage)
    }  
    
    
    // Image-Picker schließen
    dismiss(animated: true, completion: nil)
  }      // Ende func
}        // Ende extension
