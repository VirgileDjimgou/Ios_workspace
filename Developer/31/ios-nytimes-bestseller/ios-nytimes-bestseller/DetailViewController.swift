//
//  DetailViewController.swift
//  ios-nytimes-bestseller
//
//  Created by Michael Kofler on 09.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  // Details zu diesem Buch anzeigen
  var book: Book?
  @IBOutlet weak var webview: UIWebView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = book?.title
    let req = URLRequest(url: book!.url)
    print("xxx Detail-View, url=\(book!.url)")
    webview.loadRequest(req)
  }
  
}
