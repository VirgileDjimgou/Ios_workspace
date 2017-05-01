//
//  ViewController.swift
//  Hello iOS
//
//  Created by Djimgou , Patrick on 30.04.17.
//  Copyright © 2017 Hochschule Aalen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var allButtons: [UIButton]!
    
    @IBAction func helloWorldClick(_ sender: UIButton) {
        let formatter = DateFormatter()
        formatter.dateFormat = "d.M.yyyy H:mm:ss"
        textView.text.append(formatter.string(from: Date()) + "\n")
    }
    
    
    @IBAction func newClick (_ sender : UIButton) {
        let val1 = allButtons[0].currentTitle!;
        let val2 = allButtons[1].currentTitle!;
        
        textView.text.append("Buttons: " + val1 + ", " + val2 + "\n")
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        textView.font = textView.font?.withSize(value)
    }
}

