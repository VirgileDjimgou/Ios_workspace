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
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let dest = segue.destinationViewController as? DetailVC,
           cell = sender as? MyCell,
          indexPath = tableView.indexPathForCell(cell)
    {
      dest.data = mydata[indexPath.row]
    }
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
      "ProtoCell", forIndexPath: indexPath) as! MyCell
    let row = indexPath.row
    cell.title.text = mydata[row].name
    cell.subTitle.text = mydata[row].capital
    
    // Zugriff auf Bilder aus Images.xcasset
    let name = mydata[row].name.stringByReplacingOccurrencesOfString(
      "ü", withString: "ue")
    cell.img.image = UIImage(named: name)
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

