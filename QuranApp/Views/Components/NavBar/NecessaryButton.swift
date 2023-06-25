//
//  NecessaryButton.swift
//  QuranApp
//
//  Created by Sulaymon on 13/06/23.
//

import SwiftUI

struct NecessaryButton: View {
    @EnvironmentObject var reviewsRequestManager: ReviewsRequestManager
    @EnvironmentObject var necessaryMenuViewModel: NecessaryMenuViewModel
    
    var body: some View {
        Menu {
            Button {
                necessaryMenuViewModel.updateStatus(.command)
            } label: {
                Label("Add your commend", systemImage: "text.bubble")
            }
            Button {
                necessaryMenuViewModel.updateStatus(.share)
            } label: {
                Label("Share with friends", systemImage: "globe.europe.africa")
            }
        } label: {
            Image(systemName: "list.bullet")
        }
    }
}

struct NecessaryButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Text("<_<")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NecessaryButton()
                    }
                }
        }
        .environmentAllObject()
    }
}
