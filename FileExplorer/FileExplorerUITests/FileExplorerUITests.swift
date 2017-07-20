//
//  FileExplorerUITests.swift
//  FileExplorerUITests
//
//  Created by Mac OS on 28.06.17.
//  Copyright © 2017 Djimgou Patrick. All rights reserved.
//

import XCTest

class FileExplorerUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
       
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        // XCUIApplication().launch()
        app = XCUIApplication()
        app.launch()
        
        

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCallFileExplorercustomUItest(){
        
        let callFileExplorerButton = app.buttons["Call File Explorer"]
        callFileExplorerButton.tap()
        let cancelButton = app.navigationBars["Documents"].buttons["Cancel"]
        cancelButton.tap()
        
        // app.buttons["create Fake InitRepo"].tap()
        app.tables.staticTexts["CreateFolderFunc"].tap()
        app.navigationBars["CreateFolderFunc"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
    
    
    }
    
    func testfuncCancelFile(){
        let callFileExplorerButton = app.buttons["Call File Explorer"]
        callFileExplorerButton.tap()
        sleep(5)
        
        let cancelButton = app.navigationBars["Documents"].buttons["Cancel"]
        cancelButton.tap()

    
    }
  
    
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
}
