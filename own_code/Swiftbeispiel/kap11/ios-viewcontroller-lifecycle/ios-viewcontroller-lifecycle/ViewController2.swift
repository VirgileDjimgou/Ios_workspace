//
//  ViewController2.swift
//  ios-viewcontroller-lifecycle
//
//  Created by Michael Kofler on 02.04.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

  func log(s:String) {
    let title = self.title ?? "kein Titel"
    print("   \(title) (hash=\(self.hashValue % 1000)): \(s) ")
    
  }
  
  // init + deinit
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    log("init")
  }
  deinit {
    log("deinit")
  }
  
  // viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    log("viewDidLoad")
  }
  
  // Appear + Disappear
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    log("viewWillAppear")
  }
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    log("viewDidAppear")
  }
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    log("viewWillDisappear")
  }
  override func viewDidDisappear(animated: Bool) {
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
  


}
