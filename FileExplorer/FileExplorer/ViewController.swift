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
        CreateFolder(folderName: "TFolder",PathFolder: "Path_von_new_Folder") // Default in Dokument
        // by default the file browser will open in  app's documents  directory.
        present(fileBrowser, animated:true,completion:nil)
        
        fileBrowser.didSelectFile = { (file: FBFile) -> Void in
            print(file.displayName)
        }
        
        
    }
    

    func CreateFolder(folderName: String , PathFolder:String) -> Bool{
        let ReturnValue = false;
        
        // Default Path ist Dokument Ordner ....
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dataPath = documentsDirectory.appendingPathComponent(folderName)
        
        do {
            try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            print("Error creating directory: \(error.localizedDescription)")
        }
        
        return ReturnValue
    
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

