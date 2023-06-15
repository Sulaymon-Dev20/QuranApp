//
//  MyAppDelegate.swift
//  QuranApp
//
//  Created by Sulaymon on 24/05/23.
//

import SwiftUI

//let aType = "uz.suyo.QuranApp"
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
        if let app {
            let routerManager = app.routerManager
            if let deepLink = response.notification.request.content.userInfo["link"] as? String, let url = URL(string: deepLink) {
                routerManager.pushDeepLink(to: url, list: app.surahViewModel.items)
            }
            app.badgeAppManager.minusBadge(number: 1)
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.sound, .badge, .banner, .list]
    }
    
    var notificationAuthStatus: Bool {
        var status = true
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized, .provisional, .ephemeral:
                status = false
            default:
                status = true
            }
        }
        return status
    }
    
    func registerForNotification() -> Bool {
        var status = true
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            status = false
            if success {
            } else if let error = error {
                print(error.localizedDescription)
            } else{
            }
        }
        return status;
    }
    
    static var orientationLock = UIInterfaceOrientationMask.portrait {
        didSet {
            UIApplication.shared.connectedScenes.forEach { scene in
                if let windowScene = scene as? UIWindowScene {
                    windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: orientationLock))
                }
            }
        }
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return MyAppDelegate.orientationLock
    }
}
