//
//  NoficationsViewModel.swift
//  QuranApp
//
//  Created by Sulaymon on 23/05/23.
//

import SwiftUI
import UserNotifications

class NotificationManager: ObservableObject {
    
    @Published var hasPermission:Bool = false
    
    init() {
        checkNotificationPermission()
    }
    
    func request() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            self.hasPermission = success
        }
    }
    
    func getAuthStatus() async {
        let status = await UNUserNotificationCenter.current().notificationSettings()
        switch status.authorizationStatus {
        case .authorized, .provisional, .ephemeral:
            hasPermission = true
        default:
            hasPermission = false
        }
    }
    
    func checkNotificationPermission() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.hasPermission = settings.authorizationStatus == .authorized
            }
        }
    }
    
    func pushNotication(item: NotificatSurah) {
        let content = UNMutableNotificationContent()
        content.title = LocalizedStringKey(item.title.localizedForm).stringValue()
        content.subtitle = LocalizedStringKey(item.subTitle).stringValue()
        content.sound = UNNotificationSound.default
        content.userInfo["link"] = "holyquran://\(item.url)"
        content.userInfo["notification"] = true
        var dateComponents = DateComponents(hour: item.time.hour, minute: item.time.minute, second: 2)
        if !item.isEveryDay {
            dateComponents.day = item.time.day
        }
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: item.isEveryDay)
        let request = UNNotificationRequest(identifier: item.id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func removeNotication(list idList:[String] = []) { 
        if !idList.isEmpty {
            UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
               var identifiers: [String] = []
               for notification:UNNotificationRequest in notificationRequests {
                   if idList.contains(notification.identifier) {
                      identifiers.append(notification.identifier)
                   }
               }
               UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
            }
        } else {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }
}
