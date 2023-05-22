//
//  FavoriteViewModel.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/8/23.
//

import SwiftUI

class FavoriteViewModel: ObservableObject {
    @Published var addedItems = [Meal]()
    
    init() {
        loadFavorites()
    }
    
    func add(addedItem: Meal) {
        addedItems.append(addedItem)
        saveFavorites()
    }
    
    func remove(at offsets: IndexSet) {
        addedItems.remove(atOffsets: offsets)
        saveFavorites()
    }
    
    func undo(addedItem: Meal) {
        if let index = addedItems.firstIndex(where: { $0.id == addedItem.id}) {
            addedItems.remove(at: index)
            saveFavorites()
        }
    }
        
    private let favoritesKey = "Favorites"
    
    private func saveFavorites() {
        do {
            let data = try JSONEncoder().encode(addedItems)
            UserDefaults.standard.set(data, forKey: favoritesKey)
        } catch {
            print("Error encoding favorites: \(error)")
        }
    }
    
    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: favoritesKey) {
            do {
                addedItems = try JSONDecoder().decode([Meal].self, from: data)
            } catch {
                print("Error decoding favorites: \(error)")
            }
        }
    }
}
