//
//  Test.swift
//  QuranApp
//
//  Created by Sulaymon on 26/05/23.
//

import SwiftUI

struct Test: View {
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
            Text("asdf")
        }
        .contextMenu {
            Label("delete", systemImage: "trash.circle")
            Label("share", systemImage: "square.and.arrow.up.circle")
        } preview: {
            Text("you can delete and do sth")
                .padding()
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
