//
//  CategoryViewModel.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/4/23.
//

import SwiftUI
import Combine

class CategoryViewModel: ObservableObject {
    @Published var categories: [Category] = []
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchDessertMeals() {
        let url = URL(string: Constants.URL.callCategoryURL)!
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: TotalCategory.self, decoder: JSONDecoder())
            .map(\.categories)
            .map { categories in
                         categories.filter { !$0.categoryTitle.lowercased().contains("pork") }
                     }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("API request failed: \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] categories in
                self?.categories = categories
            }
            .store(in: &cancellables)
    }
}
