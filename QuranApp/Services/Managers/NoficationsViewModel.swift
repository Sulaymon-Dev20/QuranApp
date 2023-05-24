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
    
    //    class func setUpLocalNotification(hour: Int, minute: Int) {
    //        // have to use NSCalendar for the components
    //        let calendar = NSCalendar(identifier: .gregorian)!;
    //        var dateFire = Date()
    //        // if today's date is passed, use tomorrow
    //        var fireComponents = calendar.components( [NSCalendar.Unit.day, NSCalendar.Unit.month, NSCalendar.Unit.year, NSCalendar.Unit.hour, NSCalendar.Unit.minute], from:dateFire)
    //        if (fireComponents.hour! > hour || (fireComponents.hour == hour && fireComponents.minute! >= minute)) {
    //            dateFire = dateFire.addingTimeInterval(86400)  // Use tomorrow's date
    //            fireComponents = calendar.components( [NSCalendar.Unit.day, NSCalendar.Unit.month, NSCalendar.Unit.year, NSCalendar.Unit.hour, NSCalendar.Unit.minute], from:dateFire);
    //        }
    //        fireComponents.hour = hour
    //        fireComponents.minute = minute
    //        dateFire = calendar.date(from: fireComponents)!
    //        let localNotification = UILocalNotification()
    //        localNotification.fireDate = dateFire
    //        localNotification.alertBody = "Record Today Numerily. Be completely honest: how is your day so far?"
    //        localNotification.repeatInterval = NSCalendar.Unit.day
    //        localNotification.soundName = UILocalNotificationDefaultSoundName;
    //        UIApplication.shared.scheduleLocalNotification(localNotification);
    //    }
    
    func pushNotication() {
        let content = UNMutableNotificationContent()
        content.title = "Feed the cat"
        content.subtitle = "It looks hungry"
        content.sound = UNNotificationSound.default
        content.badge = 199
        content.userInfo["link"] = "holyquran://juz"
        content.categoryIdentifier = "juz"        
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
        //        UNNotificationRequest(identifier: "Notication ok doki", content: content, trigger: trigger)
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
    
}
