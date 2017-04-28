//
//  Film.swift
//  tvos-trailer
//
//  Created by Michael Kofler on 29.09.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import Foundation

class Film {
  let title: String
  let descr: String
  let filmLink: URL?
  let imgLink: URL?
  
  init(title: String, descr: String, film: String, img: String) {
    self.title = title
    self.descr = descr
    self.filmLink = URL(string: film)
    self.imgLink = URL(string: img)
  }
  

  
  
  static func loadFilmsFromRss() -> [Film] {
    var films = [Film]()
    let adr = "http://trailers.apple.com/trailers/" +
              "home/rss/newtrailers.rss"
    if let url = URL(string: adr),
       let s = try? String(contentsOf: url)
    {
      let xml = SWXMLHash.parse(s)
      // Schleife über alle items in der RSS-Datei
      for item in xml["rss"]["channel"]["item"] {
        if let title = item["title"].element?.text,
          let link = item["link"].element?.text,
          let descr = item["description"].element?.text,
          let content = item["content:encoded"].element?.text
        {
          let film = Film(title: fixEncodingErrors(title),
                          descr: fixEncodingErrors(descr),
                          film: link,
                          img: getImageAdr(of: content))
          films.append(film)
        }
      }
    }
    
    return films
  }
  
  
  // extrahiert aus dem Content-String (HTML-Code) des 
  // Films den Link, der auf das Titelbild zeigt
  private static func getImageAdr(of s: String) -> String {
    // pos1: Bereich, in dem <img src=" gefunden wurde
    // pos2: Position am Ende dieses Bereichs
    // pos3: Bereich, in dem sich das nächstfolgende "-Zeichen befindet
    // pos4: Position am Anfang dieses Bereichs
    if let pos1 = s.range(of: "<img src=\"") {
      let pos2 = pos1.upperBound
      if let pos3 = s.range(of: "\"", range: pos2..<s.endIndex)
      {
        let pos4 = pos3.lowerBound
        return s[pos2..<pos4]
      }
    }
    return ""
    
  }

  // die App hat bei der Interpretation der RSS-Zeichenkette
  // Encoding-Probleme, die ich nicht lösen konnte;
  // das ist ein hässlicher, nur eingeschränkt funktionierender
  // Fix
  private static func fixEncodingErrors(_ s: String) -> String {
    var tmp = s
    let fr = ["â": "'",
              "â¦": "'",
              "Â®" : "®",
              "Ã©e" : "é"]
    for (find, replace) in fr {
      tmp = tmp.replacingOccurrences(of: find, with: replace)
    }
    return tmp
  }
}
