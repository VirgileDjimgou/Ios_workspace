//
//  ViewController.swift
//  ios-popup
//
//  Created by Michael Kofler on 21.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

  // Label für die Antwort auf den Alert-Dialog
  @IBOutlet weak var label: UILabel!
  
  // MARK: Teil 1 Popup mit Textfeld
  // wird ausgeführt, bevor der Info-Popup-Dialog angezeigt wird
  override func prepare(for segue: UIStoryboardSegue,
                        sender: Any?)
  {
    if let dest = segue.destination as? PopupViewController,
      let popPC = dest.popoverPresentationController
    {
      // steuert die erlaubte Richtung des Pfeils
      // popPC.permittedArrowDirections = [.up, .left]
      popPC.permittedArrowDirections = [.up]
      popPC.delegate = self
    }
  }
  
  // Popups auch auf iPhone als solche anzeigen
  // Aufruf aufgrund von popPC.delegate = self
  func adaptivePresentationStyle(for controller:
    UIPresentationController) -> UIModalPresentationStyle
  {
    return .none
  }
  
  // MARK: Teil 2 Slider-Popup
  
  // Slider-Popup per Code anzeigen
  @IBAction func btnSlider(_ sender: UIButton) {
    // aktuelle Hintergrundfarbe ermitteln
    var white: CGFloat = 0
    self.view.backgroundColor?.getWhite(&white, alpha: nil)
    
    // Slider-Popup-VC erzeugen und initialisieren
    let sliderVC = storyboard?
      .instantiateViewController(withIdentifier: "SliderPopup")
      as! SliderViewController
    sliderVC.sliderValue = Float(white)
    sliderVC.mainVC = self
    
    // Slider-Popup anzeigen
    sliderVC.modalPresentationStyle = .popover
    let popPC = sliderVC.popoverPresentationController!
    popPC.sourceView = sender
    popPC.sourceRect = sender.bounds
    popPC.permittedArrowDirections = .up
    popPC.delegate = self
    present(sliderVC, animated:true, completion: nil)
  }
  
  // wird aufgerufen, wenn der OK-Button des Slider-Popups gedrückt wird
  @IBAction func unwindToMainVC(_ segue: UIStoryboardSegue) {
    if let src = segue.source as? SliderViewController {
      print("Slider-Popup mit OK geschlossen")
      print("Eingestellt: \(src.slider.value)")
    }
  }
  

  // MARK: Teil 3 Ja-Nein-Dialoge
  
  // Popup-Dialog mit drei Optionen
  @IBAction func btnAlert(_ sender: UIButton) {
    // Dialog zusammenstellen
    let alert = UIAlertController(
      title: "Programmiersprache",
      message: "Womit programmieren Sie iOS-Apps?",
      preferredStyle: .alert)
    
    // Antwort 1
    alert.addAction(
      UIAlertAction(title: "Swift", style: .default, handler:
        // Closure als Parameter
        { (_) in self.label.text =
                  "Natürlich, womit sonst?" }
    ))
    
    // Antwort 2
    alert.addAction(
      UIAlertAction(title: "Objective C", style: .default)
      { // nachgestellte Closure
        (_) in self.label.text =
          "Da haben Sie aber das falsche Buch gekauft!"
      }
    )
    
    // Antwort 3
    alert.addAction(
      UIAlertAction(title: "Java", style: .default)
      { (_) in self.label.text =
        "Sie sind auf der falschen Hochzeit. " +
        "Wahrscheinlich entwickeln Sie für Android ..." }
    )
    
    
    // Dialog anzeigen
    present(alert, animated: true,
            completion: nil)
    
  }

}

