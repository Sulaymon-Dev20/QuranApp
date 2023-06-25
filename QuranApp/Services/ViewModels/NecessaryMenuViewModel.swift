//
//  NecessaryMenuViewModel.swift
//  QuranApp
//
//  Created by Sulaymon on 17/06/23.
//

import SwiftUI

class NecessaryMenuViewModel: ObservableObject {
    
    @Published var showModel:Bool = false
    @Published var status:NecessaryMenuType = .command
    
    func updateStatus(_ route: NecessaryMenuType) {
        self.status = route
        self.showModel = true
    }
    
    @ViewBuilder
    func sheetDestination() -> some View {
        switch self.status {
        case .command:
            SheetCommandView()
        case .share:
            SheetShareFriendsView()
        }
    }
}

enum NecessaryMenuType {
    case command
    case share
}
