//
//  LanguageViewModel.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import Foundation

class LanguageViewModel: ObservableObject {
    
    @Published var language:String = "en"
    
    let languageKey:String = "language"
    
    init() {
        getLanguage()
    }
    
    func getLanguage() {
        let myString = UserDefaults.standard.string(forKey: languageKey)
        self.language = myString ?? Locale.preferredLanguages[0]
    }
        
    func changeLanugae(lang: String) {
        self.language = lang
        UserDefaults.standard.set(lang, forKey: languageKey)
    }
}
