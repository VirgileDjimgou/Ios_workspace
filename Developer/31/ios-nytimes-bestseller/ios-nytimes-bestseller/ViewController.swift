//
//  ViewController.swift
//  ios-nytimes-bestseller
//
//  Created by Michael Kofler on 09.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var books = [Book]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Top-20 der NYT laden
    books = Book.loadBestsellers()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.tableFooterView = UIView(frame: CGRect.zero)
  }
  
  // Wechsel zur Detailansicht
  override func prepare(for segue: UIStoryboardSegue,
                        sender: Any?)
  {
    if segue.identifier == "segueToDetailView",
       let dest = segue.destination as? DetailViewController,
       let row = tableView.indexPathForSelectedRow?.row
    {
      dest.book = books[row]
    }
  }

}

// Datenquelle für Tabelle
extension  ViewController : UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return books.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
  {
    let reuseIdentifier = "cell"
    let row = indexPath.row
    var cell =
      tableView.dequeueReusableCell(
        withIdentifier: reuseIdentifier) as UITableViewCell?
    if (cell == nil) {
      cell =
        UITableViewCell(style: .subtitle,
                        reuseIdentifier: reuseIdentifier)
    }
    cell!.textLabel?.text =
      "\(books[row].rank). \(books[row].title)"
    cell!.detailTextLabel?.text = books[row].author
    return cell!
  }
  
  

  
  @objc(tableView:heightForRowAtIndexPath:)
  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath)
    -> CGFloat
  {
    return 40.0
  }
}

// Reaktion auf Auswahl eines Tabellenfelds
extension ViewController : UITableViewDelegate {
  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath)
  {
    print(books[indexPath.row])
    performSegue(withIdentifier: "segueToDetailView",
                 sender: self)
  }
}

