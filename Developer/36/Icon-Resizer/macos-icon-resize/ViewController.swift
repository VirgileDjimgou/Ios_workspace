//
//  ViewController.swift
//  macos-icon-resize
//
//  Created by Michael Kofler on 21.04.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  
  @IBOutlet weak var splitter: NSSplitView!
  @IBOutlet weak var leftView: OriginalIconView!
  @IBOutlet weak var origLabel: NSTextField!
  @IBOutlet weak var iconTable: NSTableView!
  @IBOutlet weak var origImg: NSImageView!
  @IBOutlet weak var settingsButton: NSButton!
  @IBOutlet weak var saveButton: NSButton!
 
  // Icon in voller Auflösung (linke Seite)
  var icon: NSImage! {
    didSet {
      origImg.image = icon
      origLabel.stringValue =
        "\(Int(icon.size.width))x\(Int(icon.size.height))"
      iconTable.reloadData()
    }
  }
  
  
  // Zeilenhöhe für Table View auf der rechten Seite
  let cellheight:CGFloat = 80
  
  // welches Set von Icons wird angezeigt
  var iconset = IconSet.iOS
  
  // Array mit den gewünschten Icon-Größen
  // und Retina-Modes, Datentyp [IconSize]
  var iconsizes = IconSize.getSizes(set: .iOS)
  
  
  // MARK: Methoden
  override func viewDidLoad() {
    super.viewDidLoad()
    // in leftView Referenz auf self speichern,
    // File-Drag&Drops empfangen
    leftView.vc = self
    leftView.register(forDraggedTypes: [NSFilenamesPboardType])
    
    // Startposition für Splitter festlegen,
    // Splitter-Ereignisse verarbeiten
    splitter.setPosition(200, ofDividerAt: 0)
    splitter.delegate = self
    
    // alle Subviews von leftView sollen Drag weitergeben
    // http://stackoverflow.com/questions/8262514
    for v in leftView.subviews {
      v.unregisterDraggedTypes()
    }
    
    // Datenquelle für die Table View
    iconTable.dataSource = self
    iconTable.delegate = self
    
    //    // Sandbox-Test
    //    var content: String = ""
    //    let str = "https://kofler.info"
    //    if let url = URL(string: str) {
    //      do {
    //        content = try String(contentsOf: url)
    //        print(content)
    //      } catch {  // sollte Fehler liefern, weil die 
    //                 // App keinen Netzwerkzugriff hat
    //        print(error.localizedDescription)
    //      }
    //    }
    
   }
  
  
  // Button: Popup-Menü anzeigen
  @IBAction func showPopup(_ sender: NSButton) {
    performSegue(withIdentifier: "menuSegue", sender: sender)
  }
  
  // Segue zum Popup-Menü
  override func prepare(for segue: NSStoryboardSegue,
                        sender: Any?)
  {
    if let icvc = segue.destinationController as? IconChoiceVC {
      icvc.mainVC = self
    }
  }
  
  // Button: speichern
  @IBAction func saveAll(_ sender: NSButton) {
    if icon == nil { return }
    
    let openFile = NSOpenPanel()
    openFile.title = "Verzeichnis zum Speichern der Icons"
    openFile.prompt = "Auswählen"
    openFile.worksWhenModal = true
    openFile.allowsMultipleSelection = false
    openFile.canChooseDirectories = true
    openFile.canChooseFiles = false
    openFile.canCreateDirectories = true
    openFile.resolvesAliases = true
    openFile.runModal()
    
    if let url = openFile.url
    {
      let folder = url.path
      for sz in iconsizes {
        if sz.x1 {
          _ = sz.save(icon, type: RetinaType.x1, folder: folder)
        }
        if sz.x2 {
          _ = sz.save(icon, type: RetinaType.x2, folder: folder)
        }
        if sz.x3 {
          _ = sz.save(icon, type: RetinaType.x3, folder: folder)
        }
      }
      
      // Finder mit dem Verzeichnis anzeigen, in dem
      // die Icons gespeichert wurden
      NSWorkspace.shared().activateFileViewerSelecting( [url] )
    }
  }
  
  // Programmende
  override func viewDidDisappear() {
    super.viewDidDisappear()
    NSApplication.shared().terminate(self)
  }
}


// MARK: Split View Delegates
extension ViewController : NSSplitViewDelegate {
  // linker Bereich nicht kleiner als 100 Pixel
  func splitView(_ splitView: NSSplitView,
                 constrainMinCoordinate
                   proposedMinimumPosition: CGFloat,
                 ofSubviewAt dividerIndex: Int)
    -> CGFloat
  {
    return 100
  }
  
  // rechter Bereich mindestens 100 Pixel breit
  func splitView(_ splitView: NSSplitView,
                 constrainMaxCoordinate
                   proposedMaximumPosition: CGFloat,
                 ofSubviewAt dividerIndex: Int)
    -> CGFloat
  {
    return max(100, view.frame.size.width - 100)
  }
}

// MARK: Table View Delegates
extension ViewController : NSTableViewDataSource,
                           NSTableViewDelegate
{
  // Anzahl der Tabelleneinträge
  func numberOfRows(in tableView: NSTableView) -> Int {
    return iconsizes.count
  }
  
  // Höhe der Zeilen
  func tableView(_ tableView: NSTableView, heightOfRow row: Int)
    -> CGFloat
  {
    return cellheight
  }
  
  // bei Änderung der Spaltenbreite neuzeichnen (um
  // die drei 'virtuellen' Spalten gleichmäßig zu verteilen)
  func tableViewColumnDidResize(_ notification: Notification) {
    iconTable.reloadData()
  }
  
  // Tabellenzelle zusammenbasteln
  func tableView(_ tableView: NSTableView,
    viewFor tableColumn: NSTableColumn?,
    row: Int) -> NSView?
  {
    
    let width  = tableColumn?.width ?? 200
    let width3 = width / 3
    let isize  = iconsizes[row]
    let n      = isize.sidelength

    // Container
    let rect = CGRect(x: 0, y: 0,
                      width: width, height: cellheight)
    let newview = NSView(frame: rect)
    
    // links: erstes Icon
    if isize.x1 {
      let name  = IconSize.iconName(prefix: "icon_",
                                    sidelength: n,
                                    type: .x1)
      newview.addSubview(
        makeLabeledIcon(0, width3, isize, .x1, name))
    }
    
    // mitte: zweites Icon für Retina
    if isize.x2 {
      let name  =  IconSize.iconName(prefix: "icon_",
                                     sidelength: n,
                                     type: .x2)
      newview.addSubview(
        makeLabeledIcon(width3, width3, isize, .x2, name))
    }
    
    // rechts: drittes Icon für Super-Retina
    if isize.x3 {
      let name  =  IconSize.iconName(prefix: "icon_",
                                     sidelength: n,
                                     type: .x3)
      newview.addSubview(
        makeLabeledIcon(width3 * 2, width3, isize, .x3, name))
    }
    
    // alles zusammen
    return newview
  }
  
  // Icon mit Beschriftung erzeugen
  private func makeLabeledIcon(_ offset: CGFloat,
                               _ width: CGFloat,
                               _ isize: IconSize,
                               _ rtype: RetinaType,
                               _ txt: String) -> NSView
  {
    let rect = CGRect(x: offset, y: 0,
                      width: width, height: cellheight)
    let iconview = IconCellView(frame: rect)
    // IconCellView-spezifische Eigenschaften
    iconview.isize = isize
    iconview.rtype = rtype
    iconview.icon = icon
    
    // Textfeld zur Beschriftung
    let txtrect = CGRect(x: 0, y: 0, width: width, height: 20)
    let lbl = NSTextField(frame: txtrect)
    lbl.stringValue = txt
    lbl.alignment = .center
    lbl.isEditable = false
    lbl.isBezeled = false
    lbl.drawsBackground = false
    iconview.addSubview(lbl)
    
    // Image-View mit Icon
    let side = cellheight - 30 // Icon-Größe
    let iconrect = CGRect(x: (width-side) / 2, y: 25,
                          width: side, height: side)
    let img = NSImageView(frame: iconrect)
    img.image = icon ?? NSImage(named: "file_question")
    iconview.addSubview(img)
    return iconview
  }
}


