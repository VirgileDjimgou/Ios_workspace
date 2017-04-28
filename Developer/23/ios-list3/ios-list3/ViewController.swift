//
//  ViewController.swift
//  ios-list3
//
//  Created by Michael Kofler on 17.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  var mydata = Country.readFromBundle()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  override func prepare(for segue: UIStoryboardSegue,
                        sender: Any?)
  {
    if let dest = segue.destination as? DetailVC,
       let cell = sender as? MyCell,
       let indexPath = tableView.indexPath(for: cell)
    {
      dest.data = mydata[indexPath.row]
    }
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
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "ProtoCell", for: indexPath) as! MyCell
    let row = indexPath.row
    cell.title.text = mydata[row].name
    cell.subTitle.text = mydata[row].capital
    
    // Zugriff auf Bilder aus Images.xcasset
    let name = mydata[row].name.replacingOccurrences(
      of: "ü", with: "ue")
    cell.img.image = UIImage(named: name)
    return cell
  }
}

// TableView-Delegates
extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath)
  {
    print(mydata[indexPath.row].name)
  }
}

