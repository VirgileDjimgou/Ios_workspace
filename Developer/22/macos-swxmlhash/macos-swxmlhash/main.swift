//
//  main.swift
//  macos-swxmlhash
//
//  Created by Michael Kofler on 08.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import Foundation

// Sub-Sitemap mit Url-Set auswerten
func processUrlset(location: String) {
  print("process \(location)")
  guard let url = URL(string: location) else { return }
  guard let data = try? String(contentsOf: url) else { return }

  // Formatter zum Einlesen
  let formatter1 = DateFormatter()
  formatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
  // Formatter 2 zur kompakten Ausgabe
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

// Sitemap auswerten, für die ersten drei
// Sub-Sitemaps die Methode xxx aufrufen
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

let xmlstring="test"
let xml = SWXMLHash.parse(xmlstring)   // Typ XMLIndexer
let x1 = xml["Root"]                   // Typ XMLIndexer
// alle Level1-Elemente verarbeiten
for x2 in xml["root"]["Level1"] {      // Typ XMLIndexer
  // ...
}
let e = xml["Root"]["Level1"].element  // Typ XMLElement?
let s = e?.text                        // Typ String? (Inhalt)
let a = e?.attribute(by: "attrname")   // Typ XMLAttribute?
let an = a?.name                       // Typ String?
let at = a?.text                       // Typ String?
let allA = e?.allAttributes            // Typ [String : XMLAttribute]?


