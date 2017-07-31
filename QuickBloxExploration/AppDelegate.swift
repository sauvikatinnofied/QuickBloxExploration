//
//  AppDelegate.swift
//  QuickBloxExploration
//
//  Created by Sauvik Dolui on 31/07/17.
//  Copyright © 2017 Innofied Solution Pvt. Ltd. All rights reserved.
//

import UIKit
import Quickblox

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setUpQuickBlox()
        connectToQuickBlox()
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


// MARK: - CUSTOM SETTINGS
extension AppDelegate {
    func setUpQuickBlox() {
        
        QBSettings.setApplicationID(60892)
        QBSettings.setAuthKey("eGEzeQfF-7vZRqw")
        QBSettings.setAccountKey("tGBCuP5LWQGjuoPagEWz")
        QBSettings.setAuthSecret("VFn7uA4DRzqYzFJ")
        
        // enabling carbons for chat
        QBSettings.setCarbonsEnabled(true)
        
        // Enables Quickblox REST API calls debug console output.
        QBSettings.setLogLevel(QBLogLevel.nothing)
        
        // Enables detailed XMPP logging in console output.
        QBSettings.enableXMPPLogging()
    }
    
    func connectToQuickBlox() {
        
        let currentUser = QBUUser()
        currentUser.id = 30695887 // your current user's ID
        currentUser.password = "Password1"; // your current user's password
        
        QBChat.instance().connect(with: currentUser) { (error) in
            if let error = error {
                print("Chat Server Connection Error: \(error.localizedDescription)")
                return
            }
            
            
            // Connection Success
            print("Connection Success")
            QBRequest.logIn(withUserLogin: "sauvik_dolui", password: "Password1",
                            successBlock: { (response, user) in
                    print("Login Success")
                    self.createADialoag(completionBlock: { (response, dialog) in
                        if let _ = dialog {
                            self.createADialoag(completionBlock: { (response, dialog) in
                                //
                            })
                        } else {
                            print("Error in creating a dialog")
                            
                        }
                    })
            }, errorBlock: { (response) in
                print("Login Error = \(String(describing: response.error?.error?.localizedDescription))")
            })
            
            
        }
    }
    
    func createADialoag(completionBlock: @escaping (QBResponse?, QBChatDialog?) -> Void) {
        
        let chatDialog = QBChatDialog(dialogID: nil, type: QBChatDialogType.group)
        chatDialog.name = "Chat with Manish"
        chatDialog.occupantIDs = [30695887, 30697285]
        
        QBRequest.createDialog(chatDialog, successBlock: { (response: QBResponse?, createdDialog : QBChatDialog?) -> Void in
            if let createdDialog = createdDialog {
                print("Created Dialog ID = \(String(describing: createdDialog.id))")
            }
            completionBlock(response, createdDialog)
            
        }) { (response : QBResponse!) -> Void in
            completionBlock(response, nil)
        }
    }
}

