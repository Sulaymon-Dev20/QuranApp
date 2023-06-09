//
//  String.swift
//  QuranApp
//
//  Created by Sulaymon on 22/05/23.
//

import SwiftUI

extension String {
    static func localizedString(for key: String, locale: String = "uz", argument: String) -> String {
        let path = Bundle.main.path(forResource: locale, ofType: "lproj")!
        let bundle = Bundle(path: path)!
        return NSLocalizedString(key, bundle: bundle, comment: "").replacingOccurrences(of: "%@", with: argument)
    }
        
    public var localizedForm: String {
        return self.lowercased().replacingOccurrences(of: "-", with: "_")
    }
    
    public var intValue: Int {
        return (self as NSString).integerValue
    }
    
    public var lv: String {//localizedVal
        return LocalizedStringKey(self).stringValue()
    }
    
    private static let formatter = NumberFormatter()

    func clippingCharacters(in characterSet: CharacterSet) -> String {
        components(separatedBy: characterSet).joined()
    }

    func convertedDigitsToLocale(_ lanuage:String = UserDefaults.standard.string(forKey: "uz.suyo.QuranApp.language") ?? "EN") -> String {
        let digits = Set(clippingCharacters(in: CharacterSet.decimalDigits.inverted))
        guard !digits.isEmpty else { return self }

        Self.formatter.locale = Locale(identifier: lanuage == "ar" ? "FA" : "EN")

        let maps: [(original: String, converted: String)] = digits.map {
            let original = String($0)
            let digit = Self.formatter.number(from: original)!
            let localized = Self.formatter.string(from: digit)!
            return (original, localized)
        }

        return maps.reduce(self) { converted, map in
            converted.replacingOccurrences(of: map.original, with: map.converted)
        }
    }
}
