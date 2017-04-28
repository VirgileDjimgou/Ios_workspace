//
//  FirstViewController.swift
//  ios-animation
//
//  Created by Michael Kofler on 04.08.15.
//  Copyright © 2015 Michael Kofler. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
  
  @IBOutlet weak var myview: UIView!
  
  // Action-Methode des Start-Buttons
  @IBAction func start(_ sender: AnyObject) {
    
    //        // Animation ohne Reset
    //        UIView.animate(withDuration: 1.5, animations:
    //          {
    //            self.myview.frame = CGRect(x: 200, y: 400,
    //                                       width: 30, height: 80)
    //            self.myview.backgroundColor = .blue
    //          }
    //        )
    //
    //        // gleichwertig
    //        UIView.animate(withDuration: 1.5) {
    //          self.myview.frame = CGRect(x: 200, y: 400,
    //                                     width: 30, height: 80)
    //          self.myview.backgroundColor = .blue
    //        }
    
    // Rechteck zum Schluss wieder an den ursprünglichen Ort
    // zurücksetzen
    UIView.animate(
      withDuration: 1.5,
      animations: {
        self.myview.frame = CGRect(x: 200, y: 400,
                                   width: 30, height: 80)
        self.myview.backgroundColor = .blue
      },
      completion: {
        (_) in
        self.myview.frame = CGRect(x: 20, y: 60,
                                   width: 60, height: 60)
        self.myview.backgroundColor = .gray
      }
    ) // Ende animate-Methode
  }   // Ende start-Methode des Buttons


}

