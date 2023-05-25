//
//  String.swift
//  QuranApp
//
//  Created by Sulaymon on 22/05/23.
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
    
    public var localizedForm: String {
        return self.lowercased().replacingOccurrences(of: "-", with: "_")
    }
    
    public var intValue: Int {
        return (self as NSString).integerValue
    }
}
