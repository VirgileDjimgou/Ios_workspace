//
//  ViewController.swift
//  Hello iOS
//
//  Created by Michael Kofler on 28.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var textView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the 
    // view, typically from a nib.
  }
  
  @IBAction func hwButtonTouch(_ sender: UIButton) {
    let now = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "d.M.yyyy H:mm:ss"
    textView.text? +=
      formatter.string(from: now) + "\n"
  }
  
  
  @IBAction func sliderMove(_ sender: UISlider) {
    textView.font =
      textView.font?.withSize(CGFloat(sender.value))
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
 }

