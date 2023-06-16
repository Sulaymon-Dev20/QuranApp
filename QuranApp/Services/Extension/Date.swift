//
//  Date.swift
//  QuranApp
//
//  Created by Sulaymon on 25/05/23.
//

import Foundation

extension Date {
    public var clockString: String {
        let hour = self.hour
        let minute = self.minute
        let hourText = hour.usefulDigits <= 1 ? "0\(hour)" : "\(hour)"
        let minuteText = minute.usefulDigits <= 1 ? "0\(minute)" : "\(minute)"
        return "\(hourText) : \(minuteText)";
    }
    
    public var dateForm: String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd"
        return dateformat.string(from: self)
    }
    
    public var timeForm: String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "HH:mm"
        return dateformat.string(from: self)
    }

    public var fullTimeForm: String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "HH:mm:ss"
        return dateformat.string(from: self)
    }
    
    public var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    public var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    public var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    public var intValue: Int {
        return Int(self.timeIntervalSince1970)
    }
    
    mutating func changeDay(day: Int) {
        var component = Calendar.current.dateComponents(in: TimeZone.current, from: self)
        component.day = day
        self = Calendar.current.date(from: component)!
    }

    func diffTwoTime(from day: Date) -> Date {
        let diffs = Calendar.current.dateComponents([.hour, .minute, .second], from: self, to: day)
        let date = Calendar.current.date(from: diffs)!
        return date
    }
}
