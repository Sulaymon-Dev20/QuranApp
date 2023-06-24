//
//  JuzListView.swift
//  QuranApp
//
//  Created by Sulaymon on 25/06/23.
//

import SwiftUI

struct JuzListView: View {
    let list: [JuzModel]
    
    @EnvironmentObject var routerManager: RouterManager
    
    var body: some View {
        if !list.isEmpty {
            List (list, id: \.index) { item in
                VStack {
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        Button {
                            routerManager.setCurrentPage(to: item.page)
                        } label: {
                            JuzRowView(item: item)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                    } else {
                        JuzRowView(item: item)
                            .overlay {
                                NavigationLink(value: Route.menu(item: item)) {
                                    Text(">>>")
                                }
                                .opacity(0)
                            }
                    }
                    
                }
            }
        } else {
            ItemNotFoundView()
        }
    }
}

struct JuzListView_Previews: PreviewProvider {
    static var previews: some View {
        JuzListView(list: [])
    }
}
