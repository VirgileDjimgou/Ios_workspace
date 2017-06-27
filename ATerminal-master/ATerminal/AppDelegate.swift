//
//  AppDelegate.swift
//  ATerminal
//
//  Created by lijunge on 15/8/8.
//  Copyright © 2015年 A. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let vc = ViewController()
        window?.rootViewController = vc
        ptyInit()
        return true
    }
    
    func ptyInit() {
        var fd: Int32 = 0
        var ch: Int8 = 0
        var ts: termios = termios()
        var ws: winsize = winsize(ws_row: 320, ws_col: 560, ws_xpixel: 0, ws_ypixel: 0)
        let pid = forkpty(&fd, &ch, &ts, &ws)
        print("forkpty succeed, the pid is\(pid)")
        guard pid != -1 else {
            print("forkpty failed")
            fatalError()
        }
        
        if pid == 0 {
            let userName = "mobile"
            /*execve(_: UnsafePointer<Int8>, _: UnsafePointer<UnsafeMutablePointer<Int8>>, _: UnsafePointer<UnsafeMutablePointer<Int8>>)*/
            //let arg1: UnsafePointer<Int8> = "j"
            //        let result = execve("/usr/bin/login", ["login", "-fp", userName, nil], ["TERM=xterm", nil])
            //        guard result != -1 else {
            //            fatalError()
            //        }
        }
        
        let processID = pid
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
