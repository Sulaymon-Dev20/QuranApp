//
//  NecessaryButton.swift
//  QuranApp
//
//  Created by Sulaymon on 13/06/23.
//

import SwiftUI

struct NecessaryButton: View {
    @Environment (\.openURL) var openURL
    @EnvironmentObject var reviewsRequestManager: ReviewsRequestManager
    
    var body: some View {
        Menu {
            Button {
                if let link = reviewsRequestManager.reviewLink {
                    openURL(link)
                }
            } label: {
                Label("Add your commend", systemImage: "text.bubble")
            }
            Button {
                 
            } label: {
                Label("Donation", systemImage: "dollarsign")
            }
            .disabled(true)
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
        .environmentObject(ReviewsRequestManager())
    }
}
