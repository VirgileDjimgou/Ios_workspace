//
//  SecondViewController.swift
//  ios-currency-calculator
//
//  Created by Michael Kofler on 06.04.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
  
  // Zugriff auf View Controller des Rechners
  var calcVC: CalcVC!
  
  
  // die beiden Währungs-Picker
  @IBOutlet weak var picker1: UIPickerView!
  @IBOutlet weak var picker2: UIPickerView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    calcVC = tabBarController!.viewControllers?.first as? CalcVC
    let cc = calcVC.cc
    picker1.dataSource = self
    picker1.delegate = self
    picker1.selectRow(cc?.currencies.index(of: calcVC.cur1) ?? 0,
      inComponent: 0, animated: true)
    picker2.dataSource = self
    picker2.delegate = self
    picker2.selectRow(cc?.currencies.index(of: calcVC.cur2) ?? 0,
      inComponent: 0, animated: true)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    picker1?.reloadAllComponents()
    picker2?.reloadAllComponents()
  }
}

extension SettingsVC: UIPickerViewDataSource, UIPickerViewDelegate {
  // Anzahl der Abschnitte
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  
  // Anzahl der Picker-Zellen
  func pickerView(_ pickerView: UIPickerView,
    numberOfRowsInComponent component: Int) -> Int
  {
    let cc = calcVC.cc
    return cc!.rates.count // * 100
  }
  
  // text only
  //  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
  //    return cc.currencies[row]
  //  }
  
  // Views für die Picker-Zellen erzeugen
  func pickerView(_ pickerView: UIPickerView,
    viewForRow row: Int,
    forComponent component: Int,
    reusing view: UIView?) -> UIView
  {
    
    if view != nil {
      // vorhandenen View wiederverwenden (der Inhalt für
      // eine bestimmte Zelle ändert sich nie)
      return view!
    } else {
      let myrow = row // % cc.rates.count falls Roll Over
      // Währungscode, 3 Buchstaben
      let txt = calcVC.cc.currencies[myrow]
      // die ersten zwei Buchstaben sind der Ländercode
      let country = CurCalc.getCountryFromCurrency(txt)
      
      // neuen View erzeugen
      let newview = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
      
      // Label mit Währungscode
      let lbl = UILabel(frame: CGRect(x: 90, y: 0, width: 60, height: 50))
      lbl.text = txt
      lbl.font = lbl.font.withSize(24)
      newview.addSubview(lbl)
      
      // Image mit Flagge
      let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
      img.image = UIImage(named: country)
      img.contentMode = .scaleAspectFit
      newview.addSubview(img)
      return newview
    }
  }
  
  // Zellenhöhe in der Mitte der Pickers
  func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
  {
    return 50
  }
  
  // erfolgreiche Auswahl --> cur1/cur2 in CalcVC ändern
  func pickerView(_ pickerView: UIPickerView,
    didSelectRow row: Int,
    inComponent component: Int)
  {
    if pickerView === picker1 {
      calcVC.cur1 = calcVC.cc.currencies[row % calcVC.cc.rates.count]
    } else if pickerView === picker2 {
      calcVC.cur2 = calcVC.cc.currencies[row % calcVC.cc.rates.count]
    }
  }
}
