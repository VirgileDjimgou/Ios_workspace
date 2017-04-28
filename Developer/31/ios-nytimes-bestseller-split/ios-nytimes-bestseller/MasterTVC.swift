//
//  MasterTVC.swift
//  ios-nytimes-bestseller-split
//
//  Created by Michael Kofler on 31.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit
// import SafariServices

class MasterTVC: UITableViewController {
  
  // Daten
  var books = [Book]()
  
  // Verweis auf Application Delegate
  let myapp = UIApplication.shared.delegate as! AppDelegate
  
  // Initialisierung
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Top-20 der NYT laden
    books = Book.loadBestsellers()

    // Auswahl erhalten
    self.clearsSelectionOnViewWillAppear = false
    
    // keine leeren Zellen unten
    self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    
    // ersten Eintrag in Master-Liste auswählen  ...
    let idx = IndexPath(row: 0, section: 0)
    self.tableView.selectRow(at: idx,
                             animated: true,
                             scrollPosition: .top)
    
    // ... und in der Detailansicht anzeigen
    myapp.detailVC?.book = books[0]

  }
  
  // Detailansicht per Segue anzeigen
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier != "segueMasterDetail" { return }
    
    if let nav = segue.destination as? UINavigationController,
       let dest = nav.topViewController as? DetailVC,
       let indexPath = self.tableView.indexPathForSelectedRow
    {
      // Datenübergabe an die Detailansicht
      dest.book = books[indexPath.row]
      // print("=== \(dest.book?.url)")
    }
  }
  
  // MARK: ab hier: Table-View-Handling
  // es gibt nur einen Abschnitt
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  // Anzahl der Listeneinträge zurückgeben
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int)
    -> Int
  {
    return books.count
  }
  
  // Listeneinträge erzeugen
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
  {
    let row = indexPath.row
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "protocell", for: indexPath)
    cell.textLabel?.text =
      "\(books[row].rank). \(books[row].title)"
    cell.detailTextLabel?.text = books[row].author
    return cell
  }

  // Höhe der Listeneinträge
  @objc(tableView:heightForRowAtIndexPath:)
  override func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath)
    -> CGFloat
  {
    return 40.0
  }

  // // Variante: Seite mit Safari View Controller anzeigen;
  // // das bietet sich hier aber nicht an; Sie müssen auch
  // // import SafariServices am Beginn der Klasse auskommentieren
  // override func tableView(_ tableView: UITableView,
  //                         didSelectRowAt indexPath: IndexPath)
  // {
  //    print(books[indexPath.row])
  //    let book = books[indexPath.row]
  //    // Seite mit SFSafariViewController anzeigen
  //    let svc = SFSafariViewController(url: book.url)
  //    self.showDetailViewController(svc, sender: nil)
  // }
  

  
}
