//
//  PrayerTimeViewModel.swift
//  QuranApp
//
//  Created by Sulaymon on 24/05/23.
//

import Foundation
import Adhan
import SwiftUI

class PrayerTimeManager: ObservableObject {
    let mashabValue: String = "mashab"
    @Published var isHanafi: Bool = true

    init() {
        getValue()
    }

    func getPrayTime(time: Date, latitude lat: Double = 0 ,longitude long: Double = 0) -> [PrayTimeModel] {
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let date = cal.dateComponents([.year, .month, .day], from: time)
        let coordinates = Coordinates(latitude: lat, longitude: long)
        var params = CalculationMethod.moonsightingCommittee.params
        params.madhab = isHanafi ? Madhab.hanafi : Madhab.shafi
        var res:[PrayTimeModel] = []
        if let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) {
            let formatter = DateFormatter()
            formatter.timeStyle = .medium
            formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
            
            res.append(PrayTimeModel(name: "fajr", time: prayers.fajr, shareText: LocalizedStringKey("fajr \(prayers.fajr)")))
            res.append(PrayTimeModel(name: "sunrise", time: prayers.sunrise, shareText: LocalizedStringKey("sunrise \(prayers.sunrise)")))
            res.append(PrayTimeModel(name: "dhuhr", time: prayers.dhuhr, shareText: LocalizedStringKey("dhuhr \(prayers.dhuhr.timeForm)")))
            res.append(PrayTimeModel(name: "asr", time: prayers.asr, shareText: LocalizedStringKey("asr \(prayers.asr)")))
            res.append(PrayTimeModel(name: "maghrib", time: prayers.maghrib, shareText: LocalizedStringKey("maghrib \(prayers.maghrib)")))
            res.append(PrayTimeModel(name: "isha", time: prayers.isha, shareText: LocalizedStringKey("isha \(prayers.isha)")))
        }
        return res
    }
    
    func firstPrayTimeIndex(preyTimes items: [PrayTimeModel]) -> Int {
        for (index,item) in items.reversed().enumerated() {
            if item.time <= Date() {
                return abs(index - items.count) - 1
            }
        }
        return 0
    }
    
    func shareText(_ items: [PrayTimeModel], lanuage:String) -> String {
        var res:String = LocalizedStringKey("prayTimeByDate \(Date())").stringValue(argument: Date().dateForm.convertedDigitsToLocale(lanuage)) + "\n"
        items.forEach { item in
            res += item.shareText.stringValue(argument: item.time.timeForm.convertedDigitsToLocale(lanuage)) + "\n"
        }
        return res
    }
    
    func saveStorage() {
        UserDefaults.standard.set(isHanafi, forKey: mashabValue)
    }

    func getValue() {
        let value = UserDefaults.standard.bool(forKey: mashabValue)
        self.isHanafi = value
    }
    
    func changeMashab(to mashab: Madhab){
        self.isHanafi = mashab == Madhab.hanafi
        saveStorage()
    }

    func changeMashab(to isHanafi: Bool){
        self.isHanafi = isHanafi
        saveStorage()
    }
    
    func getIcon(time: String) -> String {
        switch time {
        case "fajr":
            return "moon.fill"
        case "sunrise":
            return "sun.haze"
        case "dhuhr":
            return "sun.max.fill"
        case "maghrib":
            return "moon.haze.fill"
        case "isha":
            return "moon.stars"
        default:
            return "sun.max"
        }
    }
}
