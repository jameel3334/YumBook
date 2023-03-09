//
//  IngredientsView.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/8/23.
//

import SwiftUI

struct IngredientsView: View {
    @ObservedObject var viewModel = MealsViewModel()
    var id: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Ingredients:")
                .font(.headline)
            
            //                ForEach(1...20, id: \.self) { index in
            //                    if let ingredient = viewModel.meals["strIngredient\(index)"], let measure = viewModel.meals["strMeasure\(index)"] {
            //                        Text("\(ingredient) - \(measure)")
            //                    }
            //            }
        }
        .task {
            do {
                try await viewModel.fetchMeals(for: id)
            } catch {
                print("Error is here \(error)")
            }
        }
    }
}
