//
//  JsonModel.swift
//  ios-nytimes-bestseller
//
//  Created by Michael Kofler on 09.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import Foundation

struct NytTop : Decodable {
  let results: [Result]?
  
  init?(json: JSON) {
    self.results = "results" <~~ json
  }
}

struct Result : Decodable {
  let rank: Int?
  let amazon: String?
  let bookDetails: [BookDetail]?
  
  init?(json: JSON) {
    self.rank        = "rank"               <~~ json
    self.amazon      = "amazon_product_url" <~~ json
    self.bookDetails = "book_details"       <~~ json
  }
}

struct BookDetail : Decodable {
  let title: String?
  let description: String?
  let author: String?
  
  init?(json: JSON) {
    self.title       = "title"       <~~ json
    self.description = "description" <~~ json
    self.author      = "author"      <~~ json
  }
}


