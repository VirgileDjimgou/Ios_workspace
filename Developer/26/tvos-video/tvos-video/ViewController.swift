//
//  ViewController.swift
//  tvos-video
//
//  Created by Michael Kofler on 05.10.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  @IBAction func play(_ sender: AnyObject) {
    // NASA-Video von einem Raketenstart
    let url = URL(string: "http://s3.amazonaws.com/akamai.netstorage/HD_downloads/Orion_SM.mp4")!
    
    // Video2Brain-Video (Vorschau Ubuntu-Training)
    // let url = URL(string: "http://html5.v2bcdn.com/de/trailerclips/2024_trailer_WL25R.mp4?ece058df664790e5cc127b90d0e6164750fc8d48e15f36722f96d58cf535852c7e207da6bd3a38ca5927a4c73fc298035c90c75b2a97609bc183db35441aa5510cbc6fb5ce60d2de611c50a9e26e5428c0995774ffb097")!
    
    // normale Webseite ohne Video, führt zu einer irreführenden HDCP-Fehlermeldung
    // let url = URL(string: "https://kofler.info")!
    
    
    let player = AVPlayer(url: url)
    let playerVC = AVPlayerViewController()
    playerVC.player = player
    self.present(playerVC, animated: true) {
      playerVC.player!.play()
    }
  }
  
  
  
}

