//
//  Date.swift
//  QuranApp
//
//  Created by Sulaymon on 25/05/23.
//

import Foundation

extension Date {
    public var clockString: String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        let hourText = hour.usefulDigits <= 1 ? "0\(hour)" : "\(hour)"
        let minuteText = minute.usefulDigits <= 1 ? "0\(minute)" : "\(minute)"
        return "\(hourText) : \(minuteText)";
    }
}
