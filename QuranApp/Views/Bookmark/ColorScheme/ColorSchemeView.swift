//
//  ColorSchemeView.swift
//  QuranApp
//
//  Created by Sulaymon on 09/06/23.
//

import SwiftUI

struct ColorSchemeView: View {
    @EnvironmentObject var colorSchemeManager: ColorSchemeManager
    
    var body: some View {
        Section {
            Picker("Vaqtini tanlang", selection: self.$colorSchemeManager.status, content: {
                Text("light")
                    .tag(ColorSchemaStatus.light)
                Text("dask")
                    .tag(ColorSchemaStatus.dark)
                Text("system")
                    .tag(ColorSchemaStatus.auto)
            })
            .onChange(of: colorSchemeManager.status) {
                colorSchemeManager.changeColorScheme(to: $0)
            }
            .pickerStyle(SegmentedPickerStyle())
        } header: {
            Text("Application color")
        }
    }
}

struct ColorSchemeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            List {
                ColorSchemeView()
            }
        }
        .environmentObject(ColorSchemeManager())
    }
}
