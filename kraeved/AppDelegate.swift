//
//  AppDelegate.swift
//  kraeved
//
//  Created by Владимир Амелькин on 27.07.2024.
//

import SwiftUI
import YandexMapsMobile

// https://paigeshin1991.medium.com/how-to-set-up-your-swiftui-project-with-appdelegate-and-scenedelegate-64cf5566e1e7

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        YMKMapKit.setApiKey("")
        YMKMapKit.sharedInstance()
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
    
}
