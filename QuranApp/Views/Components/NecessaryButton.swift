//
//  NecessaryButton.swift
//  QuranApp
//
//  Created by Sulaymon on 13/06/23.
//

import SwiftUI

struct NecessaryButton: View {
    var body: some View {
        Menu {
            Label("Add your commend", systemImage: "text.bubble")
            Label("Donation", systemImage: "dollarsign.square")
        } label: {
            Image(systemName: "list.bullet")
        }
    }
}

struct NecessaryButton_Previews: PreviewProvider {
    static var previews: some View {
        NecessaryButton()
    }
}
