//
//  IngredientsView.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/8/23.
//

import SwiftUI

struct IngredientsView: View {
    var ingredientsAndMeasures: [String]
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            SubHeaderText(text: Constants.String.instAndMeasureTitleName)
            List(ingredientsAndMeasures, id: \.self) { item in
                Text(item)
            }
        }
    }
}
