//
//  DetailVC.swift
//  ios-list3
//
//  Created by Michael Kofler on 18.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
  
  var data:Country!
  
  @IBOutlet weak var country: UILabel!
  @IBOutlet weak var population: UILabel!
  @IBOutlet weak var area: UILabel!
  @IBOutlet weak var capital: UILabel!
  @IBOutlet weak var flag: UIImageView!
  
  // Initialisierung der Steuerelemente
  override func viewDidLoad() {
    super.viewDidLoad()
    if data == nil { return }
    
    let fmt = NSNumberFormatter()
    fmt.usesGroupingSeparator = true
    country.text = data.name
    population.text = fmt.stringFromNumber(data.population)
    
    fmt.minimumFractionDigits=2
    fmt.maximumFractionDigits=2
    area.text    = (fmt.stringFromNumber(data.area) ?? "?") + " km²"
    capital.text = data.capital
    let name = data.name.stringByReplacingOccurrencesOfString(
      "ü", withString: "ue")
    flag.image = UIImage(named: name)
  }
}
