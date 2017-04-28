//
//  ViewController.swift
//  ios-test-audio
//
//  Created by Michael Kofler on 03.10.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit

import AVFoundation
import AVKit
import MediaPlayer

import OpenAL


class ViewController: UIViewController {

  var audioPlayer: AVAudioPlayer!
  
  @IBOutlet weak var volumeSlider: UISlider!
  @IBOutlet weak var mainVolumeSlider: UISlider!
  @IBOutlet weak var positionSlider: UISlider!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Audio-Player vorbereiten
    if let path = Bundle.main.path(
      forResource: "piano", ofType: "mp3")
    {
      let url = URL(fileURLWithPath: path)
      audioPlayer = try? AVAudioPlayer(contentsOf: url,
                                       fileTypeHint: nil)
      print(audioPlayer)
      audioPlayer?.prepareToPlay()
      audioPlayer?.setVolume(volumeSlider.value,
                             fadeDuration: 0.1)
    }
    
    // die App soll im Hintergrund weiterspielen
    // (außerdem: Capabilities-Background setzen!)
    do {
      let session = AVAudioSession.sharedInstance()
      try session.setCategory(AVAudioSessionCategoryPlayback)
      try session.setActive(true)
    } catch {
      print("Playback Session konnte nicht eingerichtet werden.")
    }
    
    // die App soll Benachrichtigungen des Control Panels erhalten
    UIApplication.shared.beginReceivingRemoteControlEvents()
    
    // im Control Panel soll ein Bild und ein Titel angezeigt werden
    let mpArt = MPMediaItemArtwork(
      boundsSize: CGSize(width: 256, height: 256)) {
        _ in
        return UIImage(named: "piano")!
    }
    let info: [String: Any] = [
      MPMediaItemPropertyTitle: "Ambient somber piano music",
      MPMediaItemPropertyArtist: "Lemoncreme",
      MPMediaItemPropertyArtwork: mpArt
    ]
    MPNowPlayingInfoCenter.default().nowPlayingInfo = info
    
    // Abspielposition regelmäßig aktualisieren
    Timer.scheduledTimer(
      timeInterval: 1,
      target: self,
      selector: #selector(ViewController.updatePositionSlider),
      userInfo: nil,
      repeats: true)
  }

  // Reaktion auf Control Panel Buttons
  override func remoteControlReceived(with event: UIEvent?) {
    if let eventtype = event?.subtype {
      switch eventtype {
      case .remoteControlPlay:
        audioPlayer.play()
      case .remoteControlPause:
        audioPlayer.stop()
      case .remoteControlNextTrack,
           .remoteControlPreviousTrack:
        // wieder von Anfang beginnen
        audioPlayer.currentTime = 0
        audioPlayer.play()
      default:
        break
      }
    }
  }
  
  
  // E-Mail-Bling-Geräusch abspielen
  @IBAction func playBling(_ sender: AnyObject) {
    // Achtung: nur zu hören, wenn Telefonsignal nicht auf lautlos
    // gestellt ist (http://stackoverflow.com/questions/2720623)
    // Referenz der ID-Nummern: http://iphonedevwiki.net/index.php/AudioServices
    AudioServicesPlaySystemSound(1000)
  }

  
  // Buttons: Audio-Player mit Klavier-Melodie starten und stoppen
  @IBAction func playPiano(_ sender: AnyObject) {
    audioPlayer?.currentTime = 0
    audioPlayer?.numberOfLoops = -1
    audioPlayer?.play()
  }
  @IBAction func stopPiano(_ sender: AnyObject) {
    audioPlayer?.stop()
  }
  
  // Slider: Lautstärke einstellen (relativ zur Geräte-Lautstärke)
  @IBAction func changeVolume(_ sender: AnyObject) {
    audioPlayer?.setVolume(volumeSlider.value,
                           fadeDuration: 0.1)
  }
  
  // Slider: Gerätelautstärke ändern
  @IBAction func changeDeviceVolume(_ sender: AnyObject) {
    setSystemVolume(volume: mainVolumeSlider.value)
  }
  // Quelle: http://stackoverflow.com/questions/10286744
  func setSystemVolume(volume: Float) {
    let volumeView = MPVolumeView()
    
    for view in volumeView.subviews {
      if (NSStringFromClass(view.classForCoder) == "MPVolumeSlider") {
        let slider = view as! UISlider
        slider.setValue(volume, animated: true)
      }
    }
  }

  // Position im Stück verändern
  @IBAction func changePosition(_ sender: AnyObject) {
    audioPlayer.currentTime = audioPlayer.duration * Double(positionSlider.value)
  }
  // Slider-Position während dem Abspielen verändern
  func updatePositionSlider() {
    positionSlider.value = Float(audioPlayer.currentTime) / Float(audioPlayer.duration)
  }

  // Copyright-Fenster schließen
  @IBAction func unwindToMainView(_ segue: UIStoryboardSegue) {
    // kein Code erforderlich
  }
}

