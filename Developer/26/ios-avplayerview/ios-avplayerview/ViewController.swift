//
//  ViewController.swift
//  ios-avplayerview
//
//  Created by Michael Kofler on 04.10.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  
  @IBAction func play1(_ sender: AnyObject) {
    if let path = Bundle.main.path(
      forResource: "piano", ofType: "mp3")
    {
      let player = AVPlayer(url: URL(fileURLWithPath: path))
      let playerVC = AVPlayerViewController()
      playerVC.player = player

      // PlayerVC anzeigen
      self.present(playerVC, animated: true) {
        // Wiedergabe starten
        playerVC.player!.play()
        // im Player statt Quicktime-Logo
        // ein eigenes Bild anzeigen
        let img = UIImage(named: "piano")!
        let imgView = UIImageView(image: img)
        imgView.contentMode = .scaleAspectFill
        imgView.frame = (playerVC.contentOverlayView?.bounds)!
        playerVC.contentOverlayView?.addSubview(imgView)
      }
    }
  }
  
    // Copyright-Fenster schließen
  @IBAction func unwindToMainView(_ segue: UIStoryboardSegue) {
    // kein Code erforderlich
  }

}

