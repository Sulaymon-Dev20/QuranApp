//
//  NecessaryMenuViewModel.swift
//  QuranApp
//
//  Created by Sulaymon on 17/06/23.
//

import Foundation
import SwiftUI

class NecessaryMenuViewModel: ObservableObject {
    @Published var item:NecessaryMenuModel = NecessaryMenuModel(title: "Commandlar",
                                                                subTitle: "be honest and never shame to reveil my errors it isn`t s",
                                                                button: "Appstore",
                                                                lottieView: .init(name: "Commant", bundle: .main),
                                                                isFill: true, loop: false,
                                                                action: {
        print("ok")
                                 })
    @Published var showModel:Bool = false
    
    public func updateItem(menuType status:NecessaryMenuType) {
        switch status {
        case .command:
            self.item = NecessaryMenuModel(title: "Commandlar",
                                           subTitle: "be honest and never shame to reveil my errors it isn`t s",
                                           button: "Appstore",
                                           lottieView: .init(name: "Commant", bundle: .main),
                                           isFill: true, loop: false,
                                           action: {
                UIApplication.shared.open(URL(string: "https://apps.apple.com/app/id6448216007?action=write-review")!, options: [:])
                self.showModel = false
            })
        case .share:
            self.item = NecessaryMenuModel(title: "Share",subTitle: "lekin kamchiliklarimiz bo`lsa ayting va biz uni tuzishga hakat qilamiz", button: "asdf", lottieView: .init(name: "Share", bundle: .main), isFill: false, loop: true, action: {
                
            })
        case .donate:
            self.item = NecessaryMenuModel(title: "Commandlar",subTitle: "lekin kamchiliklarimiz bo`lsa ayting va biz uni tuzishga hakat qilamiz", button: "asdf", lottieView: .init(name: "Share", bundle: .main), isFill: false, loop: true, action: {
                
            })
        }
        self.showModel = true
    }
}

enum NecessaryMenuType {
    case command
    case share
    case donate
}
