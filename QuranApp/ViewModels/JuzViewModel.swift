//
//  JuzViewModel.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import Foundation

class JuzViewModel: ObservableObject {
    @Published var items:[JuzModel] = []
    
    init() {
        loadData()
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
}
