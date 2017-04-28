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
       target: self,
       action: #selector(ViewController.handleLongPress(_:)))
    lpgr.minimumPressDuration=1.2  // in Sekunden
    tableView.addGestureRecognizer(lpgr)
  }
  
  
  // Button 'Bearbeiten / OK'
  @IBAction func editButton(_ sender: UIButton) {
    if tableView.isEditing {
      // Edit abschließen
      tableView.setEditing(false, animated: true)
      newButton.isEnabled = true
      editButton.setTitle("Bearbeiten", for: UIControlState())
    } else {
      // Edit starten
      tableView.setEditing(true, animated: true)
      newButton.isEnabled = false
      editButton.setTitle("OK", for: UIControlState())
    }
  }
  
  // Button 'To-do'
  @IBAction func addItem(_ sender: UIButton) {
    showPopup(sender: sender, mode: "new")
  }
  
  // Long Press -> Edit
  func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
    // nur das Event .began ist hier von Interesse
    if gesture.state != .began { return }
    
    // wohin hat der Benutzer gedrückt?
    let pt = gesture.location(in: tableView)
    let path = tableView.indexPathForRow(at: pt)
    if let row = (path as NSIndexPath?)?.row,
           let cell = tableView.cellForRow(at: path!)
    {
      // Long Press auf Tabellenzellen -->
      // Popup zum Andern anzeigen
      showPopup(sender: cell,
                mode: "edit",
                text: todoList[row],
                row: row)
    }
  }
  
  
  // Eingabe-Popup anzeigen, wahlweise zum Ändern
  // eines vorhandenen Eintrags oder zum Eingeben eines 
  // neuen Eintrags (mode="edit" / mode="new")
  // für edit-Modus: bisheriger Text im Parameter currentText
  func showPopup(sender: UIView, mode:String,
                 text:String="", row:Int=0)
  {
    if !(mode=="edit" || mode=="new") { return }
    
    // Eingabe-Popup vorbereiten
    let popVC = storyboard?
      .instantiateViewController(withIdentifier: "NewPopup")
      as! NewPopupVC
    popVC.mode = mode
    popVC.currentText = text
    popVC.currentRow = row
    popVC.modalPresentationStyle = .popover
    
    // Presentation Controller konfigurieren
    let popPC = popVC.popoverPresentationController!
    popPC.sourceView = sender
    popPC.sourceRect = sender.bounds
    popPC.delegate = self
    popPC.permittedArrowDirections = [.up, .down]
    
    // Popup anzeigen
    present(popVC, animated:true, completion: nil)
  }
  
  // Popover wurde mit 'OK' beendet
  @IBAction func unwindToMainVC(_ segue: UIStoryboardSegue) {
    // gegebenenfalls neuen Eintrag am Ende einfügen
    // und dorthin scrollen
    if let src = segue.source as? NewPopupVC,
       let txt = src.txt.text
    {
      let trimtxt = txt.trimmingCharacters(
                      in: .whitespacesAndNewlines)
      if trimtxt != "" {
        if src.mode == "new" {
          // neuen Eintrag hinzufügen
          todoList.append(trimtxt)
          let path = IndexPath(row: todoList.count-1, section: 0)
          tableView.insertRows(at: [path], with: .automatic)
          tableView.scrollToRow(at: path, at: .top,
                                animated: true)
        }
        else if src.mode == "edit" {
          // vorhandenen Eintrag ändern
          todoList[src.currentRow] = trimtxt
          let path = IndexPath(row: src.currentRow,
                               section: 0)
          tableView.reloadRows(at: [path], with: .automatic)
        }
      }    // Ende if trimtxt != ""
    }      // Ende if-let
  }        // Ende unwind-Methode
}          // Ende class

// damit Popups auf dem iPhone funktionieren
extension ViewController : UIPopoverPresentationControllerDelegate {
  func adaptivePresentationStyle(
         for controller: UIPresentationController)
    -> UIModalPresentationStyle
  {
    return .none
  }
}


// DataSource-Methoden
extension ViewController: UITableViewDataSource {
  // Anzahl der Abschnitte der Liste
  func numberOfSections(in tableView: UITableView) -> Int
  {
    return 1
  }
  
  // Anzahl der Listenelemente
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int
  {
    return todoList.count
  }
  
  // Darstellung der Tabellenzellen
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "ProtoCell", for: indexPath) 
    cell.textLabel?.text = todoList[indexPath.row]
    return cell
  }
  

  // alle Einträge sind veränderlich (für Delete on Swipe)
  func tableView(_ tableView: UITableView,
                 canEditRowAt indexPath: IndexPath) -> Bool
  {
    return true
  }
  
  // Eintrag löschen
  func tableView(_ tableView: UITableView,
                commit editingStyle: UITableViewCellEditingStyle,
                forRowAt indexPath: IndexPath)
  {
    if editingStyle == .delete {
      todoList.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
  
  // Verschieben für alle Elemente erlauben
  func tableView(_ tableView: UITableView,
                 canMoveRowAt indexPath: IndexPath) -> Bool
  {
    return true
  }

  // Verschieben durchführen
  func tableView(_ tableView: UITableView,
                 moveRowAt sourceIndexPath: IndexPath,
                 to destinationIndexPath: IndexPath)
  {
    let item  = todoList[sourceIndexPath.row]
    todoList.remove(at: sourceIndexPath.row)
    todoList.insert(item, at: destinationIndexPath.row)
  }
  
}

// TableView-Delegates
extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath)
  {
      print(todoList[(indexPath as NSIndexPath).row])
  }
}
