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
    let Util = Utility()

    @IBAction func TestButton(_ sender: UIButton) {
        // create new Folder for Test  Test Folder Function ... but is Optionnal .
        // Default folder ist Dokuments-Ordner... es kann später geandert werden
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        Util.CreateFolder(folderName: "TestFakeFolder", documentsPath : documentsDirectory)
        
        // call Explorer on Default  Directory ...  Documents 
        CallExplorer(StartPathExplorer: "PathLocalDirectoryForStart")
 
        
    }
    
    func  CallExplorer(StartPathExplorer : String)-> Bool{
        var ReturnValue = false
        
        
        do {
            try   // by default the file browser will open in  app's documents  directory.
                present(fileBrowser, animated:true,completion:nil)
            
            fileBrowser.didSelectFile = { (file: FBFile) -> Void in
                print(file.displayName)
            }
            // init Value ...
            ReturnValue = true; // alles hat gut funktionniert ...
            
        } catch {
            print("Error info: \(error)")
        }
        
        return  ReturnValue;
        
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

