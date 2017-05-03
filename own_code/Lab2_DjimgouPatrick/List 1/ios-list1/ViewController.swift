//
//  ViewController.swift
//  ios-list1
//
//  Created by Michael Kofler on 17.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var mydata = ["Baden-Württemberg", "Bayern", "Berlin",
    "Brandenburg", "Bremen", "Hamburg", "Hessen",
    "Mecklenburg-Vorpommern", "Niedersachsen",
    "Nordrhein-Westfalen", "Rheinland-Pfalz",
    "Saarland", "Sachsen", "Sachsen-Anhalt",
    "Schleswig-Holstein", "Thüringen"]

  override func viewDidLoad() {
    super.viewDidLoad()
    // Delegates in dieser Klasse hier verarbeiten
    tableView.delegate = self
    tableView.dataSource = self
  }
}

// DataSource-Methoden
extension ViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return mydata.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ProtoCell", for: indexPath)
    cell.textLabel!.text = mydata[(indexPath as NSIndexPath).row]
    return cell
  }
}

// TableView-Delegates
extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(mydata[(indexPath as NSIndexPath).row])
  }
}

