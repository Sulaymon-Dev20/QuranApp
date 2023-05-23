//
//  NoficationsViewModel.swift
//  QuranApp
//
//  Created by Sulaymon on 23/05/23.
//

import SwiftUI
import UserNotifications

@MainActor
class NoficationsViewModel: ObservableObject {
    
    @Published private(set) var hasPermission:Bool = false
    
    init() {
        Task{
            await getAuthStatus()
        }
    }
    
    func request() async {
        do {
            self.hasPermission = try await UNUserNotificationCenter.current().requestAuthorization(options:[.alert,.sound])
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

    func pushNotication() {
        let content = UNMutableNotificationContent()
        content.title = "Feed the cat"
        content.subtitle = "It looks hungry"
        content.sound = UNNotificationSound.default
//                    var dateComponents = DateComponents()
//                    dateComponents.calendar = Calendar.current
//
//                    dateComponents.weekday = 3  // Tuesday
//                    dateComponents.hour = 14    // 14:00 hours
//                    dateComponents.minute = 12
//
//                    // Create the trigger as a repeating event.
//                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//
//                     show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
}
