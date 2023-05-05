//
//  Test.swift
//  QuranApp
//
//  Created by Sulaymon on 05/05/23.
//

import SwiftUI

struct Test: View {
    @State var isActive: Bool = false
    var body: some View {
        NavigationStack {
            List {
                Text("View")
                .overlay {
                    NavigationLink(destination: { Text("Test") },
                                   label: { EmptyView() })
                        .opacity(0)
                }
            }
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
