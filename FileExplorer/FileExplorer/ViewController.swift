//
//  ViewController.swift
//  FileExplorer
//
//  Created by Mac OS on 28.06.17.
//  Copyright © 2017 Djimgou Patrick. All rights reserved.
//

import UIKit
import FileBrowser

class ViewController: UIViewController {

    @IBAction func TestButton(_ sender: UIButton) {
        sleep(1)
        // by default the file browser will open in  app's documents  directory.
        let fileBrowser = FileBrowser()
        present(fileBrowser, animated:true,completion:nil)
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

