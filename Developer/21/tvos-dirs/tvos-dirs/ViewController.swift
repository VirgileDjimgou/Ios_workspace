//
//  ViewController.swift
//  tvos-dirs
//
//  Created by Michael Kofler on 23.08.16.
//  Copyright © 2016 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    
    let fm = FileManager.default
    
    let home = NSHomeDirectory()
    print("home:  \(home)")
    
    let doc = fm.urls(for: .documentDirectory,
                      in: .userDomainMask).first!.path
    print("doc:   \(doc)")
    
    let lib = fm.urls(for: .libraryDirectory,
                      in: .userDomainMask).first!.path
    print("lib:   \(lib)")
    
    let cac = fm.urls(for: .cachesDirectory,
                      in: .userDomainMask).first!.path
    print("cache: \(cac)")
    
    let tmp = NSTemporaryDirectory()
    print("tmp:   \(tmp)")
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

