//
//  ViewController.swift
//  ios-gloss
//
//  Created by Michael Kofler on 09.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    if let url = Bundle.main.url(forResource: "sample",
                                 withExtension: "json"),
       let data = try? Data(contentsOf: url),
       let json = try? JSONSerialization.jsonObject(
             with: data,
             options: JSONSerialization.ReadingOptions())
           as! [String: AnyObject]
    {
      let top = Top(json: json)
      print("value=\(top?.menu?.value)")
      print("id=\(top?.menu?.id)")
      if let items = top?.menu?.popup?.menuitem {
        for item in items {
          print("   value=\(item.value!) -- onclick=\(item.onclick!)")
        }
      }
    }
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

