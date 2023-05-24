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
        Task{
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
    
    func pushNotication(id: String, title: String, subtitle: String, url: String, repeats: Bool = true, date: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = UNNotificationSound.default
//        content.badge = 0
        content.userInfo["link"] = "holyquran://\(url)"

        let calendar = Calendar.current
        var dateComponents = DateComponents(hour: calendar.component(.hour, from: date),minute: calendar.component(.month, from: date))
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: repeats)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
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
