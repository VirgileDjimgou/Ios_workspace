//
//  ViewController.swift
//  ios-viewcontroller-lifecycle
//
//  Created by Michael Kofler on 02.04.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var txtView: UITextView!
  
  func log(_ s:String) {
    let title = self.title ?? "kein Titel"
    print("\(title) (hash=\(self.hashValue % 1000)): \(s) ")
  }
  
  // wird nicht ausgeführt, weil diese App
  // keine NIBs verwendet
  override init(nibName nibNameOrNil: String?,
                bundle nibBundleOrNil: Bundle?)
  {
    // Eigenschaften der Basisklasse initialisieren
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    // eigener Code ...
    log("init(nibName:bundle:)")
  }
  
  // init + deinit
  required init?(coder aDecoder: NSCoder) {
    // Eigenschaften der Basisklasse initialisieren
    super.init(coder: aDecoder)
    // eigener Code
    log("init(coder:)")
    
    // Vorsicht: dieser Code löst einen Fehler aus,
    // weil txtView zu diesem Zeitpunkt noch nicht
    // initialisiert ist
    // txtView.layer.borderColor = UIColor.lightGray.cgColor
    // txtView.layer.borderWidth = 1
    // txtView.layer.cornerRadius = 6
  }
  deinit {
    log("deinit")
  }

  // viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    log("viewDidLoad")
    
    // hier funktioniert der Code
    // txtView.layer.borderColor = UIColor.lightGray.cgColor
    // txtView.layer.borderWidth = 1
    // txtView.layer.cornerRadius = 6
    
    // let appDelegate =
    //   UIApplication.shared.delegate as! AppDelegate
  }
  
  // Appear + Disappear
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    log("viewWillAppear")
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    log("viewDidAppear")
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    log("viewWillDisappear")
  }
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    log("viewDidDisappear")
  }
  
  // Layout
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    log("viewWillLayoutSubviews")
  }
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    log("viewDidLayoutSubviews")
  }
  
  // Rücksprung aus View 2
  @IBAction func unwindToView1(_ segue: UIStoryboardSegue) {
    
  }

  
}

