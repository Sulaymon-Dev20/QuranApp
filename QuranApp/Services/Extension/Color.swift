//
//  Color.swift
//  QuranApp
//
//  Created by Sulaymon on 19/06/23.
//

import SwiftUI

extension Color {
    static let dynamicColor = Color(UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? .black : .white
    })
}
