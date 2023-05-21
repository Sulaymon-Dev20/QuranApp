//
//  CustomExtension .swift
//  QuranApp
//
//  Created by Sulaymon on 21/05/23.
//

import Foundation
import SwiftUI

extension String {
    static func localizedString(for key: String, locale: String = "uz") -> String {
        let path = Bundle.main.path(forResource: locale, ofType: "lproj")!
        let bundle = Bundle(path: path)!
        let localizedString = NSLocalizedString(key, bundle: bundle, comment: "")
        return localizedString
    }
}


extension LocalizedStringKey {
    var stringKey: String? {
        Mirror(reflecting: self).children.first(where: { $0.label == "key" })?.value as? String
    }

    func stringValue(locale: String = UserDefaults.standard.string(forKey: "language") ?? "en") -> String {
        return .localizedString(for: self.stringKey ?? "en", locale: locale)
    }
}
