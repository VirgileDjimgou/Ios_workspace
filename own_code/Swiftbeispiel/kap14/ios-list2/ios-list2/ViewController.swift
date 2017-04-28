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
  func numberOfSectionsInTableView(tableView: UITableView) -> Int
  {
    return 1
  }
  
  // gibt die Anzahl der Listenelemente an
  func tableView(tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int
  {
    return mydata.count
  }
  
  // liefert Tabellenzellen zur Darstellung im Steuerelement
  func tableView(tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath)
    -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCellWithIdentifier(
      "ProtoCell", forIndexPath: indexPath) 
    let row = indexPath.row
    cell.textLabel?.text = mydata[row].name
    cell.detailTextLabel?.text = mydata[row].capital
    
    // falls PNGs als Bundle-Dateien mitgeliefert werden
    //    if let path = NSBundle.mainBundle().pathForResource(mydata[row].name, ofType: "png") {
    //      println(path)
    //      cell.imageView?.image = UIImage(named: path)!
    //    }
    
    // Zugriff auf Bilder aus Images.xcasset
    let name = mydata[row].name.stringByReplacingOccurrencesOfString(
      "ü", withString: "ue")
    cell.imageView?.image = UIImage(named: name)
    
    return cell
  }
}

// TableView-Delegates
extension ViewController: UITableViewDelegate {
  func tableView(tableView: UITableView,
    didSelectRowAtIndexPath indexPath: NSIndexPath)
  {
    print(mydata[indexPath.row].name)
  }
}
