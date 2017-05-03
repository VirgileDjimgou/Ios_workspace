//
//  Queue_Funktionen.swift
//  Dispatch:Queue
//
//  Created by Mac OS on 03.05.17.
//  Copyright © 2017 Djimgou Patrick. All rights reserved.
//

import Foundation

import UIKit

class Calculator {
    func doCalc(_ value : Double) {
        sqrt(abs(value))
    }
    
    func performCalculation (iterations: Int, output: UITextView, tag: String) {
        let start = CFAbsoluteTimeGetCurrent()
        for value in 0 ..< iterations {
            self.doCalc(Double(value))
        }
        let end = CFAbsoluteTimeGetCurrent()
        DispatchQueue.main.async {
            output.text.append("Time for \(tag):  \(String(format: "%2.2f", end-start)) seconds\n")
        }
    }
}
