//
//  ViewController.swift
//  ios-avplayerview
//
//  Created by Michael Kofler on 04.10.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

  let avPlayer = AVPlayer()
  @IBOutlet weak var statusLbl: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    Timer.scheduledTimer(
    withTimeInterval: 0.5, repeats: true) {
      _ in self.updateStatus()
    }
  }

  @IBAction func playLocal(_ sender: AnyObject) {
    let path = Bundle.main.path(
      forResource: "piano", ofType: "mp3")!
    let url = URL(fileURLWithPath: path)
    let ava = AVAsset(url: url)
    let avItem = AVPlayerItem(asset: ava)
    avPlayer.replaceCurrentItem(with: avItem)
    avPlayer.play()

    NotificationCenter.default.addObserver(self,
      selector: #selector(ViewController.updateStatus),
      name: .AVPlayerItemDidPlayToEndTime,
      object: nil)
    
  }
  
  @IBAction func playFast(_ sender: AnyObject) {
    let path = Bundle.main.path(
      forResource: "piano", ofType: "mp3")!
    let url = URL(fileURLWithPath: path)
    let ava = AVAsset(url: url)
    let avItem = AVPlayerItem(asset: ava)
    avPlayer.replaceCurrentItem(with: avItem)
    avPlayer.play()
    avPlayer.rate = 1.5
    
  }
  
  @IBAction func playRadio(_ sender: AnyObject) {
    // HTTP muss in info.plist frei geschalten werden
    let url = URL(string:
      "http://mp3stream1.apasf.apa.at:8000/listen.pls")!
    let ava = AVAsset(url: url)
    let avItem = AVPlayerItem(asset: ava)
    avPlayer.replaceCurrentItem(with: avItem)
    avPlayer.play()
    avPlayer.rate = 1.0
  }
  
  
  @IBAction func stop(_ sender: AnyObject) {
    avPlayer.pause()
  }
  
  @IBAction func forwards(_ sender: AnyObject) {
    let time = avPlayer.currentTime()
    let tensecs = CMTimeMakeWithSeconds(10, 1)
    avPlayer.seek(to: CMTimeAdd(time, tensecs))
  }
  @IBAction func backwards(_ sender: AnyObject) {
    let time = avPlayer.currentTime()
    let tensecs = CMTimeMakeWithSeconds(10, 1)
    avPlayer.seek(to: CMTimeSubtract(time, tensecs))
  }
  // Copyright-Fenster schließen
  @IBAction func unwindToMainView(_ segue: UIStoryboardSegue) {
    // kein Code erforderlich
  }

  func updateStatus() {
    if avPlayer.rate != 0.0 && avPlayer.error == nil {
      let time = CMTimeGetSeconds(avPlayer.currentTime())
      statusLbl.text = "playing \(time)"
    } else {
      statusLbl.text = "not playing"
    }
  }
}

