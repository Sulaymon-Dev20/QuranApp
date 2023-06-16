//
//  NecessaryButton.swift
//  QuranApp
//
//  Created by Sulaymon on 13/06/23.
//

import SwiftUI

struct NecessaryButton: View {
    @EnvironmentObject var reviewsRequestManager: ReviewsRequestManager
    
    var body: some View {
        Menu {
            Button {
            } label: {
                Label("Add your commend", systemImage: "text.bubble")
            }
            Button {
                 
            } label: {
                Label("Share with friends", systemImage: "globe.europe.africa")
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
