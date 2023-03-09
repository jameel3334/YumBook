//
//  MealsViewModel.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/7/23.
//

import SwiftUI
import Combine

class MealsViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    static let instance = NetworkManager()
    let service: APIServiceProtocol
    
    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }
    
    func fetchMeals(for id: String) async throws {
        do {
            let data = try await service.fetchData(from: "\(Constants.URL.callMeal)\(id)" , for: TotalMeal.self)
            Task { @MainActor in
                meals = data.meals
            }
        } catch {
            throw NetworkingError.invalidData
        }
    }
}
