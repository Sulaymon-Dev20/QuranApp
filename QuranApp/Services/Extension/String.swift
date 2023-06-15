//
//  String.swift
//  QuranApp
//
//  Created by Sulaymon on 22/05/23.
//

import Foundation
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

    public func locVal(_ lanuageCode:String = "uz", capitalized:Bool = false) -> String {//localizedVal
        if capitalized {
            return LocalizedStringKey(self).stringValue(locale: lanuageCode).capitalized
        } else {
            return LocalizedStringKey(self).stringValue(locale: lanuageCode)
        }
    }
    
    private static let formatter = NumberFormatter()

    func clippingCharacters(in characterSet: CharacterSet) -> String {
        components(separatedBy: characterSet).joined()
    }

    func convertedDigitsToLocale(_ lanuage:String) -> String {
        let digits = Set(clippingCharacters(in: CharacterSet.decimalDigits.inverted))
        guard !digits.isEmpty else { return self }

        Self.formatter.locale = lanuage == "ar" ? Locale(identifier: "FA") : Locale(identifier: "EN")

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
