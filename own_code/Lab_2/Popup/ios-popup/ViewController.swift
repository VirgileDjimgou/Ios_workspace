//
//  ViewController.swift
//  ios-popup
//
//  Created by Michael Kofler on 21.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

  var gray:Float = 1.0
  
  
  // Slider-Popup per Code anzeigen
  @IBAction func btnSlider(_ sender: UIButton) {
    let sliderVC = storyboard?.instantiateViewController(withIdentifier: "SliderPopup") as! SliderViewController
    sliderVC.modalPresentationStyle = .popover
    sliderVC.sliderValue = gray
    let popPC = sliderVC.popoverPresentationController!
    popPC.sourceView = sender
    popPC.sourceRect = sender.bounds
    popPC.permittedArrowDirections = .up
    popPC.delegate = self
    present(sliderVC, animated:true, completion: nil)
  }
  
  @IBAction func btnAlert(_ sender: UIButton) {
    // Dialog zusammenstellen
    let alert = UIAlertController(
      title: "Programmiersprache",
      message: "Womit programmieren Sie iOS-Apps?",
      preferredStyle: .alert)
    
    // Antwort 1
    alert.addAction(
      UIAlertAction(title: "Swift", style: .default, handler:
        { (_) in print("Natürlich -- womit sonst?") }
      ))
    
    // Antwort 2
    alert.addAction(
      UIAlertAction(title: "Objective C", style: .default, handler:
        { (_) in print("Da haben Sie aber das falsche Buch gekauft!") }
      ))
    
    // Antwort 3
    alert.addAction(
      UIAlertAction(title: "Java", style: .default, handler:
        { (_) in print("Sie sind auf der falschen Hochzeit -- wahrscheinlich entwickeln Sie für Android ...") }
      ))
    
    
    // Dialog anzeigen
    present(alert, animated: true,
      completion: nil)

  }
  
  
  // wird ausgeführt, bevor der Info-Popup-Dialog angezeigt wird
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let dest = segue.destination as? PopupViewController,
           let popPC = dest.popoverPresentationController
    {
      // popPC.permittedArrowDirections = .Right
      popPC.delegate = self
    }
  }
  
  // Popups auch auf iPhone als solche anzeigen
  // Aufruf aufgrund von popPC.delegate = self
  func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
    return .none
  }
  
  // wird aufgerufen, wenn der OK-Button des Slider-Popups gedrückt wird
  @IBAction func unwindToMainVC(_ segue: UIStoryboardSegue) {
    if let src = segue.source as? SliderViewController {
      gray = src.slider.value
      view.backgroundColor = UIColor(white: CGFloat(gray), alpha: 1.0)
    }
  }
  
}

