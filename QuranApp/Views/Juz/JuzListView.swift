//
//  JuzListView.swift
//  QuranApp
//
//  Created by Sulaymon on 25/06/23.
//

import SwiftUI

struct JuzListView: View {
    let list: [JuzModel]
    
    var body: some View {
        if !list.isEmpty {
            List (list, id: \.index) { item in
                JuzRowView(item: item)
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
