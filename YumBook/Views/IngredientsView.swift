//
//  IngredientsView.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/8/23.
//

import SwiftUI

struct IngredientsView: View {
    @ObservedObject var viewModel = MealsViewModel()
    var ingredientsAndMeasures: [String]
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Text("Ingredients - Measurements")
                .font(.headline)
            List(ingredientsAndMeasures, id: \.self) { items in
                Text(items)
            }
        }
    }
}
