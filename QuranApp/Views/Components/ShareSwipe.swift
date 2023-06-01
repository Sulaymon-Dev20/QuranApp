//
//  ShareSwipe.swift
//  QuranApp
//
//  Created by Sulaymon on 01/06/23.
//

import SwiftUI

struct ShareSwipe: View {
    let title:String
    let index:String

    var body: some View {
        ShareLink(item: title, subject: Text(title), message: Text("holyquran://surahs?index=\(index)"), preview: SharePreview(title, icon: "link.circle.fill")) {
            Label("ShareLink", systemImage:  "link.circle.fill")
        }
        .tint(.blue)
    }
}

struct ShareSwipe_Previews: PreviewProvider {
    static var previews: some View {
        ShareSwipe(title: "112", index: "112")
    }
}
