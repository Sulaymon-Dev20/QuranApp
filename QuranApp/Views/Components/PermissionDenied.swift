//
//  PermissionDenied.swift
//  QuranApp
//
//  Created by Sulaymon on 25/05/23.
//

import SwiftUI

struct PermissionDenied: View {
    let img: String
    let text: LocalizedStringKey
    var body: some View {
        VStack {
            Image(systemName: img)
                .font(.system(size: 50.0))
           Text(text)
                .bold()
        }
    }
}

struct PermissionDenied_Previews: PreviewProvider {
    static var previews: some View {
        PermissionDenied(img: "paperplane.circle.fill", text: "Location Denited")
    }
}
