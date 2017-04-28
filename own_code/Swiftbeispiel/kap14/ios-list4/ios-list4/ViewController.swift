//
//  ViewController.swift
//  ios-list4
//
//  Created by Michael Kofler on 18.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var editButton: UIButton!
  @IBOutlet weak var newButton: UIButton!
  
  var todoList = Todo.load()  {
    didSet {  // bei jeder Änderung sofort speichern
      Todo.save(todoList)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    
    // langer Klick auf Tabellenzelle zum Ändern
    // http://stackoverflow.com/questions/3924446
    let lpgr = UILongPressGestureRecognizer(
       target: self, action: #selector(ViewController.handleLongPress(_:)))
    lpgr.minimumPressDuration=1.2  // long press: etwas länger als eine Sekunde
      tableView.addGestureRecognizer(lpgr)
  
  }
  
  
  // Button 'Bearbeiten / OK'
  @IBAction func editButton(sender: UIButton) {
    if tableView.editing {
      // Edit abschließen
      tableView.setEditing(false, animated: true)
      newButton.enabled = true
      editButton.setTitle("Bearbeiten", forState: UIControlState.Normal)
    } else {
      // Edit starten
      tableView.setEditing(true, animated: true)
      newButton.enabled = false
      editButton.setTitle("OK", forState: UIControlState.Normal)
    }
  }
  
  // Button '+'
  @IBAction func addItem(sender: UIButton) {
    showPopup(sender, mode: "new")
  }
  
  // Long Press -> Edit
  func handleLongPress(gesture: UILongPressGestureRecognizer) {
    // nur erstes Event (UIGestureRecognizerStateBegan) 
    // ist hier von Interesse
    if gesture.state != .Began { return }
    
    // wohin hat der Benutzer gedrückt?
    let pt = gesture.locationInView(tableView)
    let path = tableView.indexPathForRowAtPoint(pt)
    if let row = path?.row,
           cell = tableView.cellForRowAtIndexPath(path!)
    {
      // Long Press auf Tabellenzellen -->
      // Popup zum Andern anzeigen
      showPopup(cell, mode:"edit", text:todoList[row], row:row)
    }
  }
  
  
  // Eingabe-Popup anzeigen, wahlweise zum Ändern
  // eines vorhandenen Eintrags oder zum Eingeben eines 
  // neuen Eintrags (mode="edit" / mode="new")
  // für edit-Modus: bisheriger Text im Parameter currentText
  func showPopup(sender: UIView, mode:String, text:String="", row:Int=0) {
    if !(mode=="edit" || mode=="new") { return }
    // Eingabe-Popup vorbereiten
    let popVC = storyboard?
      .instantiateViewControllerWithIdentifier("NewPopup")
      as! NewPopupVC
    popVC.mode = mode
    popVC.currentText = text
    popVC.currentRow = row
    popVC.modalPresentationStyle = .Popover
    
    // Presentation Controller konfigurieren
    let popPC = popVC.popoverPresentationController!
    popPC.sourceView = sender
    popPC.sourceRect = sender.bounds
    popPC.delegate = self
    popPC.permittedArrowDirections = [.Up, .Down]
    
    // Popup anzeigen
    presentViewController(popVC, animated:true,
      completion: nil)
  }
  
  // Popover wurde mit 'OK' beendet
  @IBAction func unwindToMainVC(segue: UIStoryboardSegue) {
    // eventuell neuen Eintrag am Ende einfügen und dorthin scrollen
    if let src = segue.sourceViewController as? NewPopupVC,
           txt = src.txt.text
    {
      let trimtxt = txt.stringByTrimmingCharactersInSet(
        NSCharacterSet.whitespaceAndNewlineCharacterSet())
      if trimtxt != "" {
        if src.mode == "new" {
          // neuen Eintrag hinzufügen
          todoList.append(trimtxt)
          let path = NSIndexPath(forRow: todoList.count-1, inSection: 0)
          tableView.insertRowsAtIndexPaths([path], withRowAnimation: .Automatic)
          tableView.scrollToRowAtIndexPath(path,
            atScrollPosition: .Top, animated: true)
        } else if src.mode == "edit" {
          // vorhandenen Eintrag ändern
          todoList[src.currentRow] = trimtxt
          let path = NSIndexPath(forRow: src.currentRow,
            inSection: 0)
          // tableView.reloadData()
          tableView.reloadRowsAtIndexPaths([path], withRowAnimation: .Automatic)
        }
      }
    }
  }
}

// damit Popups auf dem iPhone funktionieren
extension ViewController : UIPopoverPresentationControllerDelegate {
  func adaptivePresentationStyleForPresentationController(
    controller: UIPresentationController) ->
      UIModalPresentationStyle
  {
    return .None
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
    return todoList.count
  }
  
  // liefert Tabellenzellen zur Darstellung im Steuerelement
  func tableView(tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath)
    -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCellWithIdentifier(
      "ProtoCell", forIndexPath: indexPath) 
    let row = indexPath.row
    cell.textLabel?.text = todoList[row]
    return cell
  }
  

  // jeder Eintrag  ist veränderlich; erforderlich, damit
  // Swipe nach rechts Delete auslöst
  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  // Eintrag löschen
  func tableView(tableView: UITableView,
                commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                forRowAtIndexPath indexPath: NSIndexPath)
  {
    if editingStyle == .Delete {
      let row = indexPath.row
      todoList.removeAtIndex(row)
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
  }
  
  // Reorder erlauben
  func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }

  // Reorder durchführen
  func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
    let item  = todoList[sourceIndexPath.row]
    todoList.removeAtIndex(sourceIndexPath.row)
    todoList.insert(item, atIndex: destinationIndexPath.row)
  }
  
}

// TableView-Delegates
extension ViewController: UITableViewDelegate {
  func tableView(tableView: UITableView,
    didSelectRowAtIndexPath indexPath: NSIndexPath)
  {
      print(todoList[indexPath.row])
  }
}