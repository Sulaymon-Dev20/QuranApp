//
//  PrayerTimeViewModel.swift
//  QuranApp
//
//  Created by Sulaymon on 24/05/23.
//

import Foundation
import Adhan

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
            
            res.append(PrayTimeModel(name: "fajr", time: prayers.fajr))
            res.append(PrayTimeModel(name: "sunrise", time: prayers.sunrise))
            res.append(PrayTimeModel(name: "dhuhr", time: prayers.dhuhr))
            res.append(PrayTimeModel(name: "asr", time: prayers.asr))
            res.append(PrayTimeModel(name: "maghrib", time: prayers.maghrib))
            res.append(PrayTimeModel(name: "isha", time: prayers.isha))
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
