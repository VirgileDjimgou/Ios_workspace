//
//  FileExplorerTests.swift
//  FileExplorerTests
//
//  Created by Mac OS on 28.06.17.
//  Copyright © 2017 Djimgou Patrick. All rights reserved.
//

import XCTest
@testable import FileExplorer

class FileExplorerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testCreatenewFolder(){
        let Util = Utility()
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        XCTAssertTrue(Util.CreateFolder(folderName: "CreateFolderFunc", documentsPath: documentsDirectory ),"cannot create folder in opt directory")
        
    }
    
    func testFileExist(){
      let Util = Utility()
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        Util.exists(path: documentsPath)
       
    }
    
    func testWriteonFile(){
        let Util = Utility()
        // Test Dirctory ist documnets ... 
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        XCTAssertTrue(Util.WriteOnFile(FileName: "TestFile.list", PathUrl: documentsDirectory ),"cannot create folder in opt directory")
        // XCTAssertTrue(Util.WriteOnFile(FileName : String , PathUrl : URL) , "cannot create write on file ...")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
