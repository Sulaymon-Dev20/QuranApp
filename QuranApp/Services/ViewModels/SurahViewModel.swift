//
//  SurahViewModel.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import Foundation

class SurahViewModel: ObservableObject {
    @Published var items:[SurahModel] = []
    
    init() {
        loadData()
    }
    
    func loadData() {
        guard let url = Bundle.main.url(forResource: "surah", withExtension: "json")
        else {
            print("Json file not found")
            return
        }
        let data = try? Data(contentsOf: url)
        let surahs = try? JSONDecoder().decode([SurahModel].self, from: data!)
        self.items = surahs!
    }
    
    func getSurahByPage(_ page: Int) -> SurahModel? {
        for item in items.reversed() {
            if item.pages.intValue <= page {
                return item
            }
        }
        return nil
    }
}
