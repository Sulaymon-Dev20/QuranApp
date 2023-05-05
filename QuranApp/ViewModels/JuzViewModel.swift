//
//  JuzViewModel.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import Foundation

class JuzViewModel: ObservableObject {
    @Published var items:[JuzModel] = []
    @Published var showStatus:Bool = false
    let juzViewStatusKey:String = "book_mark_list"

    init() {
        loadData()
        getJuzViewStatus()
    }
    
    func loadData() {
        guard let url = Bundle.main.url(forResource: "juz", withExtension: "json")
        else {
            print("Json file not found")
            return
        }
        let data = try? Data(contentsOf: url)
        let juzs = try? JSONDecoder().decode([JuzModel].self, from: data!)
        self.items = juzs!
    }
    
    func getJuzViewStatus() {
        let myString = UserDefaults.standard.object(forKey: juzViewStatusKey) as? Bool
        self.showStatus = myString ?? false
    }
        
    func changeView(status: Bool) {
        self.showStatus = status
        UserDefaults.standard.set(status, forKey: juzViewStatusKey)
    }
}
