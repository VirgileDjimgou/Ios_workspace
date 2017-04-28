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
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return mydata.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(
      "ProtoCell", forIndexPath: indexPath) 
    cell.textLabel!.text = mydata[indexPath.row]
    return cell
  }
}

// TableView-Delegates
extension ViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    print(mydata[indexPath.row])
  }
}

