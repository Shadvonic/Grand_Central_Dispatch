//
//  AppDelegate.swift
//  Whitehouse_Petitions
//
//  Created by Marc Moxey on 5/25/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

            //window turns to UITabBarVC
            if let tabBarController = window?.rootViewController as? UITabBarController {
                //finds main loads in our bundle
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //loads into  UI StoryBoard
                //Instantiate in NavController, using identifier called 'NavController'
                let vc = storyboard.instantiateViewController(withIdentifier: "NavController")
                //attach TabBarItem to VC
                vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
                //append to VC array to show tabBarItem
                tabBarController.viewControllers?.append(vc)
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

