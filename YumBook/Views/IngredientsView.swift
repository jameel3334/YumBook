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
        VStack {
            SubHeaderText(text: Constants.String.instAndMeasureTitleName)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
            List(ingredientsAndMeasures, id: \.self) { item in
                Text(item)
            }
        }
    }
}
