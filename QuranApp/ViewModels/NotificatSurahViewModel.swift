//
//  NotificatSurahViewModel.swift
//  QuranApp
//
//  Created by Sulaymon on 23/05/23.
//

import Foundation

class NotificatSurahViewModel: ObservableObject {
    
    @Published var items:[NotificatSurah] = [] {
        didSet {
            saveStorage()
        }
    }
    
    let storageKey:String = "notificat_surah"
    
    init() {
        getItems()
    }
    
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: storageKey),
            let saveItems = try? JSONDecoder().decode([NotificatSurah].self, from: data)
        else { return }
        self.items = saveItems
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
        saveStorage()
    }
    
    func moveItem(from: IndexSet,to: Int) {
        items.move(fromOffsets: from, toOffset: to)
        saveStorage()
    }
    
    func getPages() -> [Int]{
        return items.map { $0.pageNumber }
    }
    
    func saveOrDelete(item: NotificatSurah) {
        if items.contains(where: { $0.time == item.time}) {
            items = items.filter {$0.time != item.time}
        } else {
            items.append(item)
        }
        saveStorage()
    }
    
    func saveStorage(){
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: storageKey)
        }
    }
}
