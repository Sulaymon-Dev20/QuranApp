//
//  PrayerTimeViewModel.swift
//  QuranApp
//
//  Created by Sulaymon on 24/05/23.
//

import Foundation
import Adhan

class PrayerTimeViewModel: ObservableObject {

    func getPrayTime(time: Date, madhab: Madhab) -> [PrayTimeModel] {
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let date = cal.dateComponents([.year, .month, .day], from: time)
        let coordinates = Coordinates(latitude: 41.311081, longitude: 69.240562)
        var params = CalculationMethod.moonsightingCommittee.params
        params.madhab = madhab
        var res:[PrayTimeModel] = []
        if let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) {
            let formatter = DateFormatter()
            formatter.timeStyle = .medium
            formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
            
            res.append(PrayTimeModel(name: "fajr", time: prayers.fajr))
            res.append(PrayTimeModel(name: "dhuhr", time: prayers.dhuhr))
            res.append(PrayTimeModel(name: "asr", time: prayers.asr))
            res.append(PrayTimeModel(name: "maghrib", time: prayers.maghrib))
            res.append(PrayTimeModel(name: "isha", time: prayers.isha))
        }
        return res
    }
}
