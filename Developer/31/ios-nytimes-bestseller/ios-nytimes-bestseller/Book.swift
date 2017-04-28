//
//  Book.swift
//  ios-nytimes-bestseller
//
//  Created by Michael Kofler on 09.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import Foundation

struct Book {
  let title: String
  let author: String
  let rank: Int
  let url: URL
  
  init(title: String, author: String, rank: Int, url: URL) {
    self.title = title
    self.author = author
    self.rank = rank
    self.url = url
  }
  
  static func loadBestsellers() -> [Book] {
    // wenn Sie aus diesem Beispiel eine eigene App
    // machen, fordern Sie bitte einen eigenen
    // NYT-API-Key an: http://developer.nytimes.com/
    
    var books = [Book]()
    let nyt = "https://api.nytimes.com/svc/books/v3/lists.json?api-key=01050a75f5c349e6a6199a06255e7aad&list=hardcover-fiction"
    
    if let url = URL(string: nyt),
      let data = try? Data(contentsOf: url),
      let json = try? JSONSerialization.jsonObject(
        with: data,
        options: JSONSerialization.ReadingOptions())
        as! [String: AnyObject]
    {
      if let results = NytTop(json: json)?.results {
        for r in results {
          if let details = r.bookDetails?.first,
             let title   = details.title,
             let author  = details.author,
             let rank    = r.rank,
             let amazon  = r.amazon,
             let url     = URL(string: amazon)
          {
            books.append(Book(title: title,
                              author: author,
                              rank: rank,
                              url: url))
          }
        }  // Ende for-Schleife
      }    // Ende if let results = ...
    }      // Ende if let url = ...
    return books
  }
  
}
