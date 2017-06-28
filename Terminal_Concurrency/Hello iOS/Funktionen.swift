//
//  Calculator.swift
//  Hello iOS
//
//  Created by Djimgou, Patrick virgile on 03.05.17.
//  Copyright © 2017 Hochschule Aalen. All rights reserved.
//

import Foundation

import UIKit

class Funktionen{
    func doCalc() {
        var x=100
        var y = x*x
        _ = y/x
    }
    
    func performOutputConsole (iterations: Int, output: UITextView, tag: String) {
        // anstatt print  wird hier output Text wir hierd benutzt um die Ausgabe auf dem  TextView zu senden
        
        DispatchQueue.main.async {
            output.text.append("User@gitterm:-$ \(tag)\(String()) \n")
        }
    }
}
