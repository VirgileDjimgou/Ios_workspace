//
//  ViewController.swift
//  macos-gdc1
//
//  Created by Michael Kofler on 28.09.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

  // Outlets
  @IBOutlet weak var txtLoop: NSTextField!
  @IBOutlet weak var txtThreads: NSTextField!
  @IBOutlet weak var btnStart: NSButton!
  @IBOutlet weak var btnCancel: NSButton!
  // in Attributinspektor eingestellt: min = 0, max = 1
  @IBOutlet weak var progress: NSProgressIndicator!
  @IBOutlet weak var lblResult: NSTextField!
  @IBOutlet weak var lblTime: NSTextField!
  
  
  // Zugriff auf Ergebnisvariable absichern
  private let syncQueue = DispatchQueue(
    label: "info.kofler.sync_access")
  private var internalResult = 0.0
  var result: Double {
    get {
      return syncQueue.sync { self.internalResult }
    }
    set(newValue) {
      syncQueue.sync { self.internalResult = newValue }
    }
  }
 
  // Statusvariablen, werden nur von der Main Queue verwendet
  var startTime = Date()
  var cancel = false
  var completed = 0.0
  
  // parallele DispatchQueue für die Berechnung
  let calcQueue = DispatchQueue(label: "info.kofler.conc_calc",
                                qos: .userInitiated,
                                attributes: .concurrent)
  let calcGroup = DispatchGroup()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }


  // Start-Button
  @IBAction func start(_ sender: AnyObject) {
    // sofern die Textfelder als Zahlen interpretierbar sind
    if let threads = Int(txtThreads.stringValue),
       let loop = Int(txtLoop.stringValue)
    {
      // Vorbereitungsarbeiten
      btnStart.isEnabled = false
      btnCancel.isEnabled = true
      lblResult.stringValue = "Berechnung läuft"
      lblTime.stringValue =   "Berechnung läuft"
      progress.doubleValue = 0.0
      result = 0
      completed = 0
      cancel = false
      startTime = Date()

      let loopCnt = loop * 1_000_000
      let delta = (loopCnt + threads - 1) / threads
      
      // alle Jobs starten
      for job in 0..<threads {
        let start = delta * job
        let end = min(loopCnt, delta * (job + 1))
        
        calcQueue.async(group: calcGroup) {
          self.calc(from: start, to: end, threads: threads)
        }
      } // for job
      
      // wenn alle Jobs fertig sind: done() in Main-Queue aufrufen
      calcGroup.notify(queue: DispatchQueue.main) {
        self.done()
      }
    }
    
  }
  
  // Abbrechen-Button
  @IBAction func stop(_ sender: AnyObject) {
    cancel = true
    lblResult.stringValue = "Berechnung abbrechen"
  }
  
  // summiert Sinus-Werte und addiert das Ergebnis
  // zur Variablen result; from inklusive, to exklusive
  private func calc(from start: Int, to end: Int, threads: Int) {
    let feedback = 50  // insgesamt 50 mal completed erhöhen
                       // und auf Abbruch testen
    let feedbackCnt = (end-start) / feedback
    let completedDelta = 1.0 / Double(feedback) / Double(threads)

    print("calc start=\(start) end=\(end)")
    print("completedDelta = \(completedDelta)")
    
    var intermediate = 0.0
    
    for i in start..<end {
      intermediate += sin(Double(i))
      // je nach einer Million Durchläufe
      // progressBar erweitern, evt. abbrechen
      if i % feedbackCnt == 0 {
        if cancel == true { return }
        
        DispatchQueue.main.async {
          self.completed += completedDelta
          self.progress.doubleValue = self.completed
        }

      }
    }
    result += intermediate
  }
  
  // die Job-Gruppe ist fertig (mit oder ohne Abbruch), 
  // Ergebnis anzeigen
  private func done() {
    btnStart.isEnabled = true
    btnCancel.isEnabled = false
    progress.doubleValue = 0.0
    if cancel == true {
      lblResult.stringValue = "--"
      lblTime.stringValue = "--"
    } else {
      let seconds = -startTime.timeIntervalSinceNow
      lblResult.stringValue = "Ergebnis: \(result)"
      lblTime.stringValue = "Rechenzeit: \(seconds) Sekunden"
    }
  }
  
  // zum Vergleich: synchron ohne Threading-Overhead
  @IBAction func startSync(_ sender: AnyObject) {
    if let loop = Int(txtLoop.stringValue) {
      startTime = Date()
      var sum=0.0
      for i in 0..<loop*1000000 {
        sum += sin(Double(i))
      }
      result = sum
      done()
    }
  }
  
  // Programmende beim Schließen des Fensters
  override func viewDidDisappear() {
    NSApplication.shared().terminate(self)
  }
  
  
}

