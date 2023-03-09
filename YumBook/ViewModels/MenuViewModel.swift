//
//  MenuViewModel.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/5/23.
//

import SwiftUI
import Combine

class MenuViewModel: ObservableObject {
    @Published var meals: [Menu] = []
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchMenus(for category: String) {
        let urlString = "\(Constants.URL.callMenus)\(category)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: TotalMenu.self, decoder: JSONDecoder())
            .map(\.meals)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("API request failed: \(debugPrint(error))")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] meals in
                self?.meals = meals
            }
            .store(in: &cancellables)
        
    }
}

