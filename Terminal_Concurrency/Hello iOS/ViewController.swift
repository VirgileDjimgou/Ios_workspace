//
//  ViewController.swift
//  Hello iOS
//
//  Created by Djimgou , Patrick on 30.04.17.
//  Copyright © 2017 Hochschule Aalen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var allButtons: [UIButton]!
    
    @IBOutlet weak var UserInput: UITextField!
    
    
    @IBOutlet weak var output2: UITextView!
    var git_command = ""
    
    @IBAction func TestButton(_ sender: UIButton) {
        self.output2.text = ""
        
    }
 
   
    @IBAction func CallOutput(_ sender: UIButton) {
        
        if(self.UserInput.text == ""){
            let alertController = UIAlertController(title: "iOScreator", message:
                "you must give a valid git command !", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }else{
            CallSendenTasks()
            }
    }
    
        
    func CallSendenTasks () {
        let concurrentQueue = DispatchQueue(label: "AsyncQueue", attributes: .concurrent)
        
        // Test Validity  of Git Command 
        git_command = self.UserInput.text!
        concurrentQueue.async {
            let ouput_konsole = Funktionen()
            ouput_konsole.performOutputConsole(iterations: 100_000_000, output: self.output2, tag: self.git_command)
        }
        
        // deadline  Falls Responsevon zu lange dauert .....
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.output2.text.append("Response :>"
            )
            self.output2.textColor = UIColor.red
            self.output2.text.append("Git Command / Request Anforderung konnte nicht ausgefuhrt werden ... Überprüfen Sie bitte die Verbindung mit dem Remote Server und versuchen Sie es erneut.\n"
            )
            //sleep(3);
            self.output2.textColor = UIColor.white
            // self.output2.text.append("User@gitterm:-$ ")
        }
    }
    
  
    
    
}

public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    public static func once(token: String, block: (Void) -> Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }}

