//
//  NoficationsViewModel.swift
//  QuranApp
//
//  Created by Sulaymon on 23/05/23.
//

import SwiftUI
import UserNotifications

@MainActor
class NoficationsManager: ObservableObject {
    
    @Published private(set) var hasPermission:Bool = false
    
    init() {
        Task {
            await getAuthStatus()
        }
    }
    
    func request() async {
        do {
            self.hasPermission = try await UNUserNotificationCenter.current().requestAuthorization(options:[.alert, .badge, .sound])
        } catch {
            print(error)
        }
    }
    
    func getAuthStatus() async {
        let status = await UNUserNotificationCenter.current().notificationSettings()
        switch status.authorizationStatus {
        case .authorized,
                .provisional,
                .ephemeral:
            hasPermission = true
        default:
            hasPermission = false
        }
    }
    
    func pushNotication(item: NotificatSurah) {
        let content = UNMutableNotificationContent()
        content.title = item.title
        content.subtitle = item.subTitle
        content.sound = UNNotificationSound.default
        content.userInfo["link"] = "holyquran://\(item.url)"

        let calendar = Calendar.current
        let dateComponents = DateComponents(timeZone: TimeZone(identifier: TimeZone.current.identifier), hour: calendar.component(.hour, from: item.time), minute: calendar.component(.month, from: item.time),second: 2)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: item.isEveryDay)
        let request = UNNotificationRequest(identifier: item.id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func removeNotication(list idList:[String] = []) {
        if !idList.isEmpty {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: idList)
        } else {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }
}
