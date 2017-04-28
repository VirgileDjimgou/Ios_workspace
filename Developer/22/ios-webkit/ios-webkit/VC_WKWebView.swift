//
//  VC_WKWebView.swift
//  ios-webkit
//
//  Created by Michael Kofler on 28.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit
import WebKit

class VC_WKWebView: UIViewController {

  var wkwv: WKWebView!
  
  override func loadView() {
    super.loadView()

    // WKWebView erzeugen und der root-View zuweisen
    wkwv = WKWebView()
    self.view = wkwv
    
    // Seite laden und anzeigen
    wkwv.load(URLRequest(url: myurl))
  }
  

}
