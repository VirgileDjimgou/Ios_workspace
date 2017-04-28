//
//  ViewController.swift
//  Temperature Calculator
//
//  Created by Bergen, Dominik on 22.11.16.
//  Copyright © 2016 Hochschule Aalen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var celsiusResult: UILabel!
    @IBOutlet weak var fahrenheitResult: UILabel!
    
    @IBAction func calculateButton(_ sender: UIButton) {
        var cOut = 0.0
        var fOut = 0.0
        
        if let input = Double(textField.text!) {
            cOut = (input - 32) * 5/9
            fOut = input * 1.8 + 32
            celsiusResult.text = String(format: "%3.2f", cOut)
            fahrenheitResult.text = String(format: "%3.2f", fOut)
        }
        else {
            celsiusResult.text = "NaN"
            fahrenheitResult.text = "NaN"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

