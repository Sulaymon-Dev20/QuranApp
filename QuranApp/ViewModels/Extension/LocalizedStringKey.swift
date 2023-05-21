//
//  LocalizedStringKey.swift
//  QuranApp
//
//  Created by Sulaymon on 22/05/23.
//

import Foundation
import SwiftUI

extension LocalizedStringKey {
    var stringKey: String? {
        Mirror(reflecting: self).children.first(where: { $0.label == "key" })?.value as? String
    }

    func stringValue(locale: String = UserDefaults.standard.string(forKey: "language") ?? "en") -> String {
        return .localizedString(for: self.stringKey ?? "en", locale: locale)
    }
}
