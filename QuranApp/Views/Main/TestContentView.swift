//
//  TestContentView.swift
//  QuranApp
//
//  Created by Sulaymon on 23/06/23.
//

import SwiftUI

struct TestContentView: View {
    @State var mainMenu: MenuItem? = MenuItem(id: 1, title: "asdf")
    @State var subMenu: SubMenuItem?
    @State var path: [SubMenuItem] = []
    
    var body: some View {
        NavigationSplitView {
            List(allCases, selection: $mainMenu) { item in
                NavigationLink(value: item) {
                    Text(item.title)
                }
            }
        } content: {
            List(allCases2, selection: $subMenu) { item in
                NavigationLink(value: item) {
                    Text(item.title)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        } detail: {
            NavigationStack(path: $path) {
                Text("tushunmadim aka")
            }
            .navigationDestination(for: SubMenuItem.self) { selected in
                //                    DetailView(item: selected)
                Text("\(selected.title)")
            }
        }
    }
}

struct MenuItem:Identifiable, Hashable, Equatable {
    var id: Int
    var title:String
}

let allCases:[MenuItem] = [
    MenuItem(id: 1, title: "asdf"),
    MenuItem(id: 2, title: "asdf"),
    MenuItem(id: 3, title: "asdf")
]

struct SubMenuItem:Identifiable, Hashable, Equatable {
    var id = UUID()
    var title:String
}
let allCases2:[SubMenuItem] = [SubMenuItem(title: "asdf 1 "),
                               SubMenuItem(title: "asdf 2 "),
                               SubMenuItem(title: "asdf 3 ")]

struct TestContentView_Previews: PreviewProvider {
    static var previews: some View {
        TestContentView()
    }
}
