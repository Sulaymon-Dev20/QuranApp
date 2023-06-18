//
//  TestSheet.swift
//  QuranApp
//
//  Created by Sulaymon on 18/06/23.
//

import SwiftUI

struct TestSheet: View {
    @EnvironmentObject var necessaryMenuViewModel: NecessaryMenuViewModel
    @State private var showingSheet = false

    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            AlertCustom()
//            Text("adsf")
        }
    }
}

struct TestSheet_Previews: PreviewProvider {
    static var previews: some View {
        TestSheet()
            .environmentObject(NecessaryMenuViewModel())
    }
}
