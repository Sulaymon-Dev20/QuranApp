//
//  TestShare.swift
//  QuranApp
//
//  Created by Sulaymon on 19/06/23.
//

import SwiftUI

struct TestShare: View {
    var body: some View {
        VStack {
            ShareLink(item: "Check out this new feature on iOS 16")
        }
    }
}

struct TestShare_Previews: PreviewProvider {
    static var previews: some View {
        TestShare()
    }
}
