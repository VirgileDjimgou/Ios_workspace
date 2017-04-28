//
//  ViewController.swift
//  cocoapods-test
//
//  Created by Michael Kofler on 18.09.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit
import SWXMLHash

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // Der folgende Code ist im Kapitel 'Netzwerk, XML und JSON' dokumentiert!
    let adr = "https://kofler.info/sitemap.xml"
    let url = URL(string: adr)!
    if let xmlstring = try? String(contentsOf: url) {
      let xmlhash = SWXMLHash.parse(xmlstring)
      var cnt=0
      // Schleife über XML-Dokument
      for subsitemap in xmlhash["sitemapindex"]["sitemap"] {
        if let loc = subsitemap["loc"].element?.text {
          processUrlset(location: loc)
        }
        cnt += 1  // maximal drei Sub-Sitemaps
        if cnt>=3 { break }
      }
    }

    
  }

  func processUrlset(location: String) {
    print("process \(location)")
    guard let url = URL(string: location) else { return }
    guard let data = try? String(contentsOf: url) else { return }
    
    // zwei Formatter zum Lesen und Ausgeben
    let formatter1 = DateFormatter()
    formatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    let formatter2 = DateFormatter()
    formatter2.dateFormat = "yyyy-MM-dd"
    
    // Schleife über XML-Dokument
    let xmlhash = SWXMLHash.parse(data)
    for siteurl in xmlhash["urlset"]["url"] {
      if let loc = siteurl["loc"].element?.text,
        let modified = siteurl["lastmod"].element?.text,
        let modDate = formatter1.date(from: modified)
      {
        print("  \(formatter2.string(from: modDate)): \(loc)")
      }
    }
  }


}

