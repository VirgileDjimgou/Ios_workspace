//
//  MainTVC.swift
//  ios-split
//
//  Created by Michael Kofler on 31.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit


class MasterTVC: UITableViewController {
  
  weak var detailVC: DetailVC!
  let myapp = UIApplication.shared.delegate as! AppDelegate
  
  // Datenbasis
  let mycolors = MyColor.makeDefault()
    
  // Initialisierungsarbeiten
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Auswahl bei Master/Detail-Wechsel erhalten
    self.clearsSelectionOnViewWillAppear = false
    
    // keine leeren Zellen unten
    self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    
    // ersten Eintrag in Master-Liste auswählen  ...
    let idx = IndexPath(row: 0, section: 0)
    self.tableView.selectRow(at: idx,
                             animated: true,
                             scrollPosition: .top)
    
    // ... und in der Detailansicht anzeigen
    myapp.detailVC?.mycolor = mycolors[0]
  }
  
  
  // MARK: Table-View-Methoden
  // nur ein Abschnitt
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  // .count Einträge
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int)
    -> Int
  {
    return mycolors.count
  }
  
  // Zellen erzeugen
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "mycell", for: indexPath)
    cell.textLabel!.text = mycolors[indexPath.row].name
    return cell
  }

  // Auswahl eines Listeneintrags
  override func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath)
  {
    print("Listenauswahl, Row = \(indexPath.row)")
    
    myapp.detailVC?.mycolor = mycolors[indexPath.row]
    // myapp.splitVC?.showDetailViewController(myapp.detailVC!,
    //                                         sender: nil)
    myapp.splitVC?.showDetailViewController(
      myapp.detailVC!.navigationController!,
      sender: nil)
  }
}
