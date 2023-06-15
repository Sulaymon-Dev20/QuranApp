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
    
    func getIds() -> [String]{
        return items.map{ $0.id }
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
        saveStorage()
    }
    
    func deleteItem(id: String) {
        items.removeAll { $0.id == id }
        saveStorage()
    }
    
    func moveItem(from: IndexSet,to: Int) {
        items.move(fromOffsets: from, toOffset: to)
        saveStorage()
    }
    
    func getPages() -> [String]{
        return items.map { $0.id }
    }
    
    func saveOrDelete(item: NotificatSurah) {
//        items.removeAll {$0.id != item.id}
        items.append(item)
        saveStorage()
    }
    
    func changeActive(id: String, time: Date, active status: Bool) {
        if var item = items.first(where: { $0.id == id }) {
            item.time = time
            item.active = status
        }
        saveStorage()
    }
    
    func checkStatus() {
        items = items.map { (item) -> NotificatSurah in
            var _item = item
            if !item.isEveryDay && item.time.intValue < Date().intValue {
                _item.active = false
            }
            return _item;
        }
        saveStorage()
    }
    
    func changeStatus(id: String, isEveryDay status: Bool) {
        var item = items.first { $0.id == id }
        item?.isEveryDay = status
        saveStorage()
    }
    
    func saveStorage(){
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: storageKey)
        }
    }
}
