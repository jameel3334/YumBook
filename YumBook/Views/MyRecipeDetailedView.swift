//
//  MyRecipeDetailedView.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 5/15/23.
//

import SwiftUI

struct MyRecipeDetailedView: View {
    let recipe: Recipe
    let title: String?
    let instructions: String?
    let ingredientAndMeasure: String?
    @State private var ingredientsIsShowing: Bool = false
    
    init(recipe: Recipe) {
        self.recipe = recipe
        self.title = recipe.title
        self.instructions = recipe.instruction
        self.ingredientAndMeasure = recipe.ingredientAndMeasure
    }
    var body: some View {
        ZStack {
            Color(Constants.Color.accentColor).opacity(Constants.General.opacityBackground)
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    DetailedImageView(imageURL: Constants.Image.defaultMenuImage)
                        .frame(width: Constants.Image.portraitViewImageDimensions, height: Constants.Image.portraitViewImageDimensions)
                        .cornerRadius(Constants.Image.menuTileCornerRadius)
                    Divider()
                    SubHeaderText(text: title ?? "No Title")
                        .multilineTextAlignment(.trailing)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
                    Spacer()
                    InfoButton(ingredientsIsShowing: $ingredientsIsShowing)
                    Spacer()
                    Divider()
                    SubHeaderText(text: Constants.String.instTitleName)
                        .multilineTextAlignment(.center)
                        .padding()
                    LabelText(text: instructions ?? "No Instructions")
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
                }
                .sheet(isPresented: $ingredientsIsShowing) {
                    VStack {
                        SubHeaderText(text: Constants.String.instAndMeasureTitleName)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                        Text(ingredientAndMeasure ?? "No Ingredients Found")
                    }
                }
            }
        }
    }
}
