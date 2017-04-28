//
//  ViewController.swift
//  ios-avrecord
//
//  Created by Michael Kofler on 04.10.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

  @IBOutlet weak var recordBtn: UIButton!
  @IBOutlet weak var stopBtn: UIButton!
  @IBOutlet weak var playBtn: UIButton!
  @IBOutlet weak var statusLbl: UILabel!
  @IBOutlet weak var timeLbl: UILabel!
  
  var recorder: AVAudioRecorder?
  var player: AVAudioPlayer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    do {
      let recSession = AVAudioSession.sharedInstance()
      try recSession.setCategory(
        AVAudioSessionCategoryPlayAndRecord)
      try recSession.setActive(true)
      recSession.requestRecordPermission() {
        allowed in
        if allowed {
          self.recordBtn.isEnabled = true
          self.statusLbl.text = "OK"
        } else {
          self.statusLbl.text = "Init-Fehler"
        }
      }
    } catch {
      statusLbl.text = "Init-Fehler"
    }
    
    // Zeit regelmäßig aktualisieren
    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) {
      _ in self.updateRecordPlayTime()
    }
  }

  // Record-Button
  @IBAction func record(_ sender: AnyObject) {
    player?.stop()
    
    // Aufnahme als MP4,
    let settings = [
      AVFormatIDKey:            Int(kAudioFormatMPEG4AAC),
      AVSampleRateKey:          44100,
      AVNumberOfChannelsKey:    1,     // mono, 2 = stereo
      AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
    ]
    
    do {
      recorder = try AVAudioRecorder(url: getFileUrl(),
                                     settings: settings)
      recorder?.delegate = self
      recorder?.record()
      stopBtn.isEnabled = true
      statusLbl.text = "Aufnahme läuft."
    } catch {
      statusLbl.text = "Aufnahme konnte nicht gestartet werden."
    }
  }
  
  // Stop-Button
  @IBAction func stop(_ sender: AnyObject) {
    player?.stop()
    recorder?.stop()  // führt zum Aufruf von 
                      // audioRecorderDidFinishRecording
  }

  // Play-Button
  @IBAction func play(_ sender: AnyObject) {
    player = try? AVAudioPlayer(contentsOf: getFileUrl())
    player?.play()
  }
  
  // URL für Datei, in der die Aufnahme gespeichert wird
  func getFileUrl() -> URL {
    let fm = FileManager.default
    let path = fm.urls(for: .documentDirectory,
                       in: .userDomainMask).first!
    return path.appendingPathComponent("record.m4a")
  }
  
  // Aufnahme- oder Abspielzeit anzeigen
  func updateRecordPlayTime() {
    if player != nil && player!.isPlaying {
      timeLbl.text = formatTime(span: player!.currentTime)
      timeLbl.textColor = .black
    } else if recorder != nil && recorder!.isRecording {
      timeLbl.text = formatTime(span: recorder!.currentTime)
      timeLbl.textColor = .red
    } else {
      timeLbl.text = "00:00"
      timeLbl.textColor = .black
    }
  }
  
  // Double-Zahl in der Form 00:00 formatieren
  private func formatTime(span: Double) -> String {
    let min = Int(span) / 60
    let sec = Int(span) % 60
    return String(format: "%02i:%02i", min, sec)
  }
}

// AVRecorder-Delegates
extension ViewController: AVAudioRecorderDelegate {
  // wird aufgerufen, wenn die Aufnahme endet
  func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder,
                                       successfully flag: Bool) {
    if flag {
      statusLbl.text = "Die Aufnahme wurde abgeschlossen."
      playBtn.isEnabled = true
    } else {
      statusLbl.text = "Die Aufnahme wurde abgebrochen."
      playBtn.isEnabled = false
    }
  }
  
}

