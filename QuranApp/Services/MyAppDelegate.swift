//
//  MyAppDelegate.swift
//  QuranApp
//
//  Created by Sulaymon on 24/05/23.
//

import SwiftUI

class MyAppDelegate: NSObject, UIApplicationDelegate, ObservableObject, UNUserNotificationCenterDelegate {
    var app: QuranAppApp?
    @objc
    func toggleColumnVisibility() {
        
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        application.registerForRemoteNotifications()
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        print(response.notification.request.content)
        let routerManager = app?.routerManager
        if let deepLink = response.notification.request.content.userInfo["link"] as? String, let url = URL(string: deepLink) {
            routerManager?.pushDeepLink(to: url, list: app?.surahViewModel.items ?? [])
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.sound, .badge, .banner, .list]
    }
}
