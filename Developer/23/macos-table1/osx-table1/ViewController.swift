//
//  ViewController.swift
//  osx-table1
//
//  Created by Michael Kofler on 24.04.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  @IBOutlet weak var table: NSTableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Datenquelle und Delegate des Tabellen-Steuerelements 
    // einstellen
    table.dataSource = self
    table.delegate = self
  }
}

extension ViewController: NSTableViewDataSource,
                          NSTableViewDelegate
{

  // die Tabelle hat 20 Zeilen
  func numberOfRows(in tableView: NSTableView) -> Int {
    return 20
  }
  
  // diese Methode gibt den Inhalt der Zellen der Tabelle zurück
  func tableView(_ tableView: NSTableView,
                 objectValueFor tableColumn: NSTableColumn?,
                 row: Int) -> Any?
  {
    let colid = tableColumn?.identifier
    let content = "Zeile \(row+1) / Spalte \(colid!)"
    print(content)
    return content
  }
  
}
