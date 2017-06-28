//
//  File.swift
//  Hello iOS
//
//  Created by Djimgou, Patrick virgile on 03.05.17.
//  Copyright © 2017 Hochschule Aalen. All rights reserved.
//

import Foundation
import UIKit

func doCalc() {
    var x=100
    var y = x*x
    _ = y/x
}

func
    
    performCalculation(iterations: Int, output: UITextView, tag: String){
    
    let start = CFAbsoluteTimeGetCurrent()
    for value in 0 ..< iterations {
         doCalc()
            }
    
    let end = CFAbsoluteTimeGetCurrent()
    
    //  in einem Textview  anstatt auf dem Konsole
    // print("time for \(tag):  \(end-start)")
  
    DispatchQueue.main.async {
        output.text.append("Time for \(tag):  \(String(format: "%2.2f", end-start)) seconds\n")
    }}
