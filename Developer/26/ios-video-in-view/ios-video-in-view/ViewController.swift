//
//  ViewController.swift
//  ios-video-in-view
//
//  Created by Michael Kofler on 11.10.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

  @IBOutlet weak var myview: UIView!
  @IBOutlet weak var timeLbl: UILabel!
  
  var player: AVPlayer!
  var layer: AVPlayerLayer!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    myview.backgroundColor = self.view.backgroundColor
    
    let url = URL(string: "http://s3.amazonaws.com/akamai.netstorage/HD_downloads/Orion_SM.mp4")!
    player = AVPlayer(url: url)
    layer = AVPlayerLayer(player: player)
    layer.videoGravity = AVLayerVideoGravityResizeAspect
    myview.layer.addSublayer(layer)
    
    Timer.scheduledTimer(withTimeInterval: 0.2,
                         repeats: true) {
      _ in self.updatePlayTime()
    }
  }

  @IBAction func play(_ sender: AnyObject) {
    // Achtung: wird nicht aktualisiert, wenn iPhone gedreht wird
    layer.frame = myview.bounds
    player?.play()
  }

  @IBAction func stop(_ sender: AnyObject) {
    player?.pause()
  }
  
  @IBAction func seekForward(_ sender: AnyObject) {
    let time = player.currentTime()
    let tensecs = CMTimeMakeWithSeconds(10, 1)
    player.seek(to: CMTimeAdd(time, tensecs))

  }
  
  @IBAction func seekBackward(_ sender: AnyObject) {
    let time = player.currentTime()
    let tensecs = CMTimeMakeWithSeconds(10, 1)
    player.seek(to: CMTimeSubtract(time, tensecs))
  }
  
  func updatePlayTime() {
    let span = Double(CMTimeGetSeconds(player.currentTime()))
    let min = Int(span) / 60
    let sec = Int(span) % 60
    timeLbl.text = String(format: "%02i:%02i", min, sec)

  }
}

