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
    
    func isExpired() -> Bool {
        return self.intValue <= Date().intValue
    }
    
    mutating func setTime(day: Int, hour: Int, min: Int, sec: Int) {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(x, from: self)

        components.timeZone = TimeZone.current
        components.day = day
        components.hour = hour
        components.minute = min
        components.second = sec
        
        if let time = cal.date(from: components) {
            self = time
        }
    }
    
    mutating func updateDayTomerrow() {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(x, from: self)

        components.timeZone = TimeZone.current
        components.day = self.day + 1
        components.hour = self.hour
        components.minute = self.minute
        components.second = 0
        
        if let time = cal.date(from: components) {
            self = time
        }
    }
}
