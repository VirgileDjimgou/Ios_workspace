//
//  DetailVC.swift
//  ios-list3
//
//  Created by Michael Kofler on 18.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
  var data:Country!    // die anzuzeigenden Daten
  
  @IBOutlet weak var country: UILabel!
  @IBOutlet weak var population: UILabel!
  @IBOutlet weak var area: UILabel!
  @IBOutlet weak var capital: UILabel!
  @IBOutlet weak var flag: UIImageView!
  
  // Initialisierung der Steuerelemente
  override func viewDidLoad() {
    super.viewDidLoad()
    if data == nil { return }
    
    // Bundesland
    country.text = data.name

    // Einwohneranzahl im Format 1.234.567
    let fmt = NumberFormatter()
    fmt.usesGroupingSeparator = true
    population.text =
      fmt.string(from: NSNumber(value: data.population))
    
    // Fläche im Format 1.234,56 km2
    fmt.minimumFractionDigits=2
    fmt.maximumFractionDigits=2
    area.text =
      (fmt.string(from: NSNumber(value: data.area)) ?? "?") + " km²"
    
    // Hauptstadt
    capital.text = data.capital
    
    // Flagge: Zugriff auf xcassets-Dateien mit äöü
    // klappt nicht; daher ü durch ue ersetzen
    let name = data.name.replacingOccurrences(
      of: "ü", with: "ue")
    flag.image = UIImage(named: name)
  }
}
