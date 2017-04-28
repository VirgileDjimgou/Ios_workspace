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
    
    // verhindert leere Zellen unterhalb des letzten Eintrags;
    // nur notwendig, wenn es weniger Listeneinträge gibt,
    // als die Table-View auf einmal anzeigen kann
    tableView.tableFooterView = UIView(frame: CGRect.zero)
  }
}

// DataSource-Methoden
extension ViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int
  {
    // die Liste hat nur einen Abschnitt
    return 1
  }
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int
  {
    // der einzige Abschnitt der Liste hat mydata.count Elemente
    return mydata.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
  {
    // versuchen, eine Zelle wiederzuverwenden
    var cell = tableView.dequeueReusableCell(
      withIdentifier: "cell")
    if cell == nil {
      // nicht möglich, daher neue Zelle erzeugen
      cell = UITableViewCell(
        style: .default, reuseIdentifier: "cell")
    }
    
    // Eigenschaften der Zelle einstellen
    cell!.textLabel!.text = mydata[indexPath.row]
    
    // Zelle zurückgeben
    return cell!
  }
}

// TableView-Delegates
extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath)
  {
    print(mydata[indexPath.row])
  }
}

