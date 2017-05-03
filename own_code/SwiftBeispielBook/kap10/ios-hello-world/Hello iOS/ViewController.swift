//
//  ViewController.swift
//  Hello iOS
//
//  Created by Michael Kofler on 11.02.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var textView: UITextView!

  @IBAction func hwButtonTouch() {
    let now = NSDate()
    let formatter = NSDateFormatter()
    formatter.dateStyle = .MediumStyle
    formatter.timeStyle = .MediumStyle
    textView.text! +=
      formatter.stringFromDate(now) + "\n"
  }
  
  @IBAction func sliderMove(sender: UISlider) {
    textView.font =
      textView.font?.fontWithSize(CGFloat(sender.value))
  }
  
  // diese beiden Methoden werden in diesem Beispiel nicht benötigt
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

