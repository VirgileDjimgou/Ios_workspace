//
//  ViewController.swift
//  ios-webkit
//
//  Created by Michael Kofler on 26.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController {

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
     }

  // Webseite extern in Safari öffnen
  @IBAction func openInSafari(_ sender: AnyObject) {
    let uiapp = UIApplication.shared
    
    uiapp.open(myurl, options: [:], completionHandler: nil)

    //    uiapp.open(myurl,
    //               options: [:],
    //               completionHandler: { self.opened(ok: $0) } )
  }

  private func opened(ok: Bool) {
    print(ok)
  }

  // Webseite intern in einem neuen Safari-View-Controller öffnen
  @IBAction func openInSafariViewController(_ sender: UIButton) {
    
    let svc = SFSafariViewController(url: myurl)
    svc.preferredControlTintColor = .black
    svc.preferredBarTintColor =
      UIColor(red: 0.9, green: 0.9, blue: 1, alpha: 1)
    present(svc, animated: true, completion: nil)
    
  }
  
}
