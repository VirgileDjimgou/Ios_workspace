//
//  DetailVC.swift
//  ios-nytimes-bestseller-split
//
//  Created by Michael Kofler on 31.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit
import WebKit

class DetailVC: UIViewController {
  // eigene Web-View
  var wkwv: WKWebView!

  // Verweis auf Application Delegate
  let myapp = UIApplication.shared.delegate as! AppDelegate

  // bei jeder Änderung von book refresh() aufrufen
  var book: Book? {
    didSet(oldvalue) {
      refresh()
    }
  }
  
  // WKWebView erzeugen
  override func loadView() {
    wkwv = WKWebView()
    self.view = wkwv
  }
  
  // beim ersten Anzeigen refresh() aufrufen
  override func viewDidLoad() {
    super.viewDidLoad()
    refresh()
  }

  // Anzeige aktualisieren
  private func refresh() {
    if book == nil  || wkwv == nil { return }
    
    // Webseite des Buchs laden
    wkwv.load(URLRequest(url: book!.url))
    
    if let nav = self.navigationController {
      // Titelleiste der Nav.bar beschriften
      nav.navigationBar.topItem?.title = book!.title
    
      // Back-Button im iPad-Hochformat anzeigen
      nav.topViewController!.navigationItem.leftBarButtonItem =
        myapp.splitVC?.displayModeButtonItem
      
      // Back-Button auf iPhone anzeigen
      nav.navigationItem.leftBarButtonItem =
        self.splitViewController?.displayModeButtonItem
      nav.navigationItem.leftItemsSupplementBackButton = true
    }
  }
  
  
}
