//
//  Alert.swift
//  QuranApp
//
//  Created by Sulaymon on 26/05/23.
//

import SwiftUI

struct AlertPermissions: View {
    @Binding var showAlert:Bool
    var title: String
    var message: String
    var body: some View {
        Text("alert")
            .opacity(0)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(title),
                    message: Text(message),
                    primaryButton: .destructive(Text("Cancel")),
                    secondaryButton: .default(
                        Text("Allow"),
                        action: {
                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        }
                    )
                )
            }
    }
}

struct Alert_Previews: PreviewProvider {
    static var previews: some View {
        AlertPermissions(showAlert: .constant(true), title: "Location allow", message: "open and allow notification please")
    }
}
