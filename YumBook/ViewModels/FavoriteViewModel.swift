//
//  FavoriteViewModel.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/8/23.
//

import SwiftUI

class FavoriteViewModel: ObservableObject {
    @Published var addedItems = [Meal]()
    
    func add(addedItem: Meal) {
        addedItems.append(addedItem)
    }
    
    func remove(at offsets: IndexSet) {
        addedItems.remove(atOffsets: offsets)
    }
    
    func undo(addedItem: Meal) {
        if let index = addedItems.firstIndex(where: { $0.id == addedItem.id}) {
            addedItems.remove(at: index)
        }
    }
}
