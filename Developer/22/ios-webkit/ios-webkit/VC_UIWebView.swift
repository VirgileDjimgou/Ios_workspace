//
//  VC_UIWebKit.swift
//  ios-webkit
//
//  Created by Michael Kofler on 28.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit

class VC_UIWebView: UIViewController {
  
  @IBOutlet weak var webview: UIWebView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    webview.loadRequest(URLRequest(url: myurl))
  }
  
}
