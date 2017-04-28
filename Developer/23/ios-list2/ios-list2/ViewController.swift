//
//  ViewController.swift
//  ios-list2
//
//  Created by Michael Kofler on 17.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  // Bundesländerdaten aus Textdatei lesen, die mit App
  // mitgeliefert wird; mydata ist ein Array von Country-Structs
  var mydata = Country.readFromBundle()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
  }



}

// DataSource-Methoden
extension ViewController: UITableViewDataSource {
  // gibt die Anzahl der Abschnitte der Liste an
  func numberOfSections(in tableView: UITableView) -> Int
  {
    return 1
  }
  
  // gibt die Anzahl der Listenelemente an
  func tableView(_ tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int
  {
    return mydata.count
  }
  
  // liefert Tabellenzellen zur Darstellung im Steuerelement
  func tableView(_ tableView: UITableView,
    cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
  {
    // Zelle aus einer Prototypzelle lesen
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "cell")!

    // Titel und Untertitel einstellen
    let row = indexPath.row
    cell.textLabel!.text = mydata[row].name
    cell.detailTextLabel?.text = mydata[row].capital
    
    
    // Bilder aus Xcassets-Datei
    let name = mydata[row].name.replacingOccurrences(
      of: "ü", with: "ue")
    cell.imageView!.image = UIImage(named: name)
    
    return cell
  }
}

// TableView-Delegates
extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath)
  {
    print(mydata[(indexPath as NSIndexPath).row].name)
  }
}
