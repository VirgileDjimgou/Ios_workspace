//
//  Utility.swift
//  FileExplorer
//
//  Created by Djimgou, Patrick virgile on 20.07.17.
//  Copyright © 2017 Djimgou Patrick. All rights reserved.
//

import Foundation
import UIKit
import FileBrowser

class Utility{
     let fileBrowser = FileBrowser()
    
    func CreateFolder(folderName: String ,documentsPath : URL) -> Bool{
        var ReturnValue = false;
        
        // Default Path ist Dokument Ordner ....
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dataPath = documentsDirectory.appendingPathComponent(folderName)
        
        
        do {
            try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
            // wenn alles ok ist dann ... 
            ReturnValue = true 
        } catch let error as NSError {
            print("Error creating directory: \(error.localizedDescription)")
        }
        
        return ReturnValue
        
    }
    
    
    func exists (path: String) -> Bool {
        return FileManager().fileExists(atPath: path)
    }
 
    
    func WriteOnFile(FileName : String , PathUrl : URL) -> Bool{
        var  ReturnValue = false;
        let fileurl =  PathUrl.appendingPathComponent(FileName)

        
        do {
            let string = try "\(NSDate())\n"
            let data = string.data(using: .utf8, allowLossyConversion: false)!
            // verify when file ist already created or exist  ...
            if FileManager.default.fileExists(atPath: fileurl.path) {
                if let fileHandle = try? FileHandle(forUpdating: fileurl) {
                    fileHandle.seekToEndOfFile()
                    fileHandle.write(data)
                    fileHandle.closeFile()
                    ReturnValue = true
                    
                }
            } else {
                ReturnValue = true
                try! data.write(to: fileurl, options: Data.WritingOptions.atomic)
            }
            
        } catch  {
             ReturnValue = false
        }
     
    
        return ReturnValue
    }

}

      
