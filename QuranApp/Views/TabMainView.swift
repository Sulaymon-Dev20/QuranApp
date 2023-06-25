//
//  TabViewMain.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct TabMainView: View {
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            IpadNavigationStack()
        } else {
            IphoneNavigationStack()
        }
    }
}

struct TabMainView_Previews: PreviewProvider {
    static var previews: some View {
        TabMainView()
            .environmentAllObject()
    }
}

