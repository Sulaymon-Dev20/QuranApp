//
//  ColorSchemeManager.swift
//  QuranApp
//
//  Created by Sulaymon on 09/06/23.
//

import SwiftUI

class ColorSchemeManager: ObservableObject {
    @Published var status: ColorSchemaStatus = .auto
    
    let storageKey = "uz.suyo.QuranApp.systemColor"
    
    init() {
        getValue()
    }
    
    func getValue() {
        let value = UserDefaults.standard.integer(forKey: storageKey)
        self.status = ColorSchemaStatus(rawValue: value)!
    }
    
    func changeColorScheme(to status: ColorSchemaStatus) {
        UserDefaults.standard.set(status.rawValue, forKey: storageKey)
        self.status = status
    }
    
    func getStatus() -> ColorScheme? {
        switch self.status {
        case ColorSchemaStatus.light:
            return ColorScheme.light
        case ColorSchemaStatus.dark:
            return ColorScheme.dark
        case ColorSchemaStatus.auto:
            return nil
        }
    }
}

enum ColorSchemaStatus : Int {
    case auto = 0
    case light = 1
    case dark = 2
}
