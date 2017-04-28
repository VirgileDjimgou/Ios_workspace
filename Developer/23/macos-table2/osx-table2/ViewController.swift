//
//  ViewController.swift
//  osx-table2
//
//  Created by Michael Kofler on 24.04.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  
  var mydata = Country.readFromBundle()
  let cellheight:CGFloat = 33
  
  @IBOutlet weak var table: NSTableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Datenquelle und Delegate der Tabelle
    table.dataSource = self
    table.delegate = self
  }
}

extension ViewController: NSTableViewDataSource,
  NSTableViewDelegate
{
  
  // Anzahl der Zeilen
  func numberOfRows(in tableView: NSTableView) -> Int {
    return mydata.count
  }
  
  // Höhe der Zeilen
  func tableView(_ tableView: NSTableView,
                 heightOfRow row: Int) -> CGFloat
  {
    return cellheight
  }
  
  // wird nach Auswahl einer Zeile oder Spalte aufgerufen
  func tableViewSelectionDidChange(_ notification: Notification) {
    if table.selectedRow >= 0 {
      print("Ausgewählt: \(mydata[table.selectedRow].name)")
    }
  }
  
  // NSView-Objekt zur Darstellung einer Tabellenzelle erzeugen
  func tableView(_ tableView: NSTableView,
                 viewFor tableColumn: NSTableColumn?,
                 row: Int) -> NSView?
  {
    if let colid = tableColumn?.identifier {
      let width = tableColumn!.width
      let formatter = NumberFormatter()
      formatter.usesGroupingSeparator = true
      // je nach Spalte differenzieren
      switch colid {
      case "flag":
        return makeImage(mydata[row].name)
      case "name":
        return makeLabel(mydata[row].name, width)
      case "capital":
        return makeLabel(mydata[row].capital, width)
      case "area":
        let area = NSNumber(value: mydata[row].area)
        let txt = formatter.string(from: area) ?? ""
        return makeLabel("\(txt) km²", width, .right)
      case "population":
        let popul = NSNumber(value: mydata[row].population)
        let txt = formatter.string(from: popul)
        return makeLabel(txt ?? "", width, .right)
      default:
        break
      }
    }
    return nil
  }
  
  // Tabelle neu sortieren
  func tableView(_ tableView: NSTableView,
                 sortDescriptorsDidChange oldDescriptors:
                   [NSSortDescriptor])
  {
    // Swift-Array in NSArray umwandeln
    let nsa = mydata as NSArray
    // NSArray sortieren und dann wieder
    // in Swift-Array zurückverwandeln
    mydata = nsa.sortedArray(
      using: tableView.sortDescriptors) as! [Country]
    table.reloadData()
  }
  
  // Textzelle für die Tabelle erzeugen
  private func makeLabel(_ txt: String,
                         _ width: CGFloat,
                         _ align: NSTextAlignment = .left)
    -> NSTextField
  {
    let rect = CGRect(x: 0, y: 0,
                      width: width, height: cellheight)
    let lbl = NSTextField(frame: rect)
    lbl.stringValue = txt
    lbl.isEditable = false
    lbl.isBezeled = false
    lbl.drawsBackground = false  // damit Highlight und Alternate funktioniert
    lbl.alignment = align
    return lbl
  }
  
  // Zelle mit Flagge für die Tabelle erzeugen
  private func makeImage(_ flagname:String) -> NSImageView
  {
    let rect = CGRect(x: 0, y: 0, width: 50, height: cellheight)
    let img = NSImageView(frame: rect)
    let name = flagname.replacingOccurrences(of: "ü", with: "ue")
    img.image = NSImage(named: name)
    return img
  }
  
}

