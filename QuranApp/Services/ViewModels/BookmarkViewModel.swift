//
//  BookmarkViewModel.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import Foundation

class BookMarkViewModel: ObservableObject {
    
    @Published var items:[BookmarkModel] = [] {
        didSet {
            saveStorage()
        }
    }
    let bookmarkKey:String = "book_mark_list"
    
    init() {
        getItems()
    }
    
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: bookmarkKey),
            let saveItems = try? JSONDecoder().decode([BookmarkModel].self, from: data)
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
    
    func saveOrDelete(item: BookmarkModel) {
        if items.contains(where: { $0.pageNumber == item.pageNumber}) {
            items = items.filter {$0.pageNumber != item.pageNumber}
        } else {
            items.append(item)
        }
        saveStorage()
    }
    
    func saveStorage(){
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: bookmarkKey)
        }
    }
}
