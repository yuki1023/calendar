//
//  AppDelegate.swift
//  ScheduleApp
//
//  Created by 篠原万由子 on 2020/08/31.
//  Copyright © 2020 net_shinohara. All rights reserved.
//

import UIKit
import NCMB




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
   
        
        
        //DBとの接続のコード
        let applicationKey = "55212b58765d14062a4b0f83afbae0a17882f2dc75b4e88c44fe4bbc0b66378f"
        let clientKey = "fca2416cd58fde21287bc7bbe6326be5023ccea56ad17d72d15900b85b28f2cd"
        NCMB.setApplicationKey(applicationKey, clientKey: clientKey)
        
        let ud = UserDefaults.standard
           if ud.object(forKey: "userName") == nil {
               NCMBUser.enableAutomaticUser()
               NCMBUser.automaticCurrentUser { (user, error) in
                   if error != nil {
                       print(error)
                   } else {
                       ud.set(user?.objectId, forKey: "userName")
                       print(ud.object(forKey: "userName"))
                   }
               }
           }
        
    
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }




}
