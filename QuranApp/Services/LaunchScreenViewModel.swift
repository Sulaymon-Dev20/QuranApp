//
//  LaunchScreenViewModel.swift
//  QuranApp
//
//  Created by Sulaymon on 22/05/23.
//

import Foundation

enum LaunchScreenPhase {
    case first
    case second
    case completed
}

final class LaunchScreenViewModel:ObservableObject {
    
    @Published private(set) var state: LaunchScreenPhase = .first
    
    func dismiss() {
        self.state = .second
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.state = .completed
        }
    }
}
