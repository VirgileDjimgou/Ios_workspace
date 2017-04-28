//
//  DetailVC.swift
//  ios-split
//
//  Created by Michael Kofler on 31.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
  
  @IBOutlet weak var lblColorName: UILabel!
  @IBOutlet weak var viewColor: UIView!
  
  // bei jeder Änderung dieser Eigenschaft den
  // Label-Text und die View-Farbe ändern
  var mycolor : MyColor? {
    didSet(oldcolor) { refresh() }
  }
  
  // damit Anzeige beim ersten Erscheinen aktuell ist
  override func viewDidLoad() {
    super.viewDidLoad()
    refresh()
  }
  
  // Label-Text und die View-Farbe aktualisieren
  private func refresh() {
    lblColorName?.text = mycolor?.name
    viewColor?.backgroundColor = mycolor?.color
  }
  
}
