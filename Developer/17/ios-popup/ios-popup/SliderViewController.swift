//
//  SliderViewController.swift
//  ios-popup
//
//  Created by Michael Kofler on 22.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class SliderViewController: UIViewController, UIPopoverPresentationControllerDelegate {

  var sliderValue: Float = 0
  weak var mainVC: ViewController!  // Verweis auf Haupt-View-Controller
  
  @IBOutlet weak var slider: UISlider!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    slider.value = sliderValue
    popoverPresentationController?.delegate = self
  }
  
  // Hintergrundfarbe des zugrundeliegenden
  // Haupt-View-Controllers verändern
  @IBAction func sliderChanged(_ sender: UISlider) {
    mainVC.view.backgroundColor =
      UIColor(white: CGFloat(slider.value), alpha: 1)
  }
  
  // wird aufgerufen, bevor das Popup durch einen Klick außerhalb 
  // ausgeblendet wird, nicht aber, wenn es regulär durch 'OK' 
  // plus Segue geschlossen wird
  func popoverPresentationControllerShouldDismissPopover(
    _ popoverPresentationController:
    UIPopoverPresentationController) -> Bool
  {
    // Aufräumarbeiten etc.
    print("should dismiss")
    return true
  }
  
}
