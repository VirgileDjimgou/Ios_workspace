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
    let fileBrowser = FileBrowser()
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

    @IBAction func TestButton(_ sender: UIButton) {
        CreateFolderVersion2()
        // by default the file browser will open in  app's documents  directory.
        present(fileBrowser, animated:true,completion:nil)
        
        fileBrowser.didSelectFile = { (file: FBFile) -> Void in
            print(file.displayName)
        }
        
        
    }
    

    func CreateFolderVersion2(){
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dataPath = documentsDirectory.appendingPathComponent("TestApp.exe")
        
        do {
            try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            print("Error creating directory: \(error.localizedDescription)")
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

