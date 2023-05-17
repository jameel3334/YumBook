//
//  MyRecipeView.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 5/4/23.
//

import SwiftUI

struct MyRecipeView: View {
    @FetchRequest(sortDescriptors: [])
    var recipeList: FetchedResults<Recipe>
    @State private var addRecipeIsShowing: Bool = false
    @State private var selectedImage: UIImage?
    var body: some View {
        NavigationView {
            List (recipeList, id: \.self) { recipe in
                NavigationLink(
                    destination: MyRecipeDetailedView(recipe: recipe)
                    ,label: {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: Constants.Image.menuTileHeightWidth, height: Constants.Image.menuTileHeightWidth)
                                .cornerRadius(Constants.Image.menuTileCornerRadius)
                                .padding(.vertical, Constants.General.constraintsTopBottom)
                            SubHeaderText(text: recipe.title)
                                .multilineTextAlignment(.leading)
                                .padding( Constants.General.constraintsTopBottom)
                        } else {
                            ListRowView(imageURL: Constants.Image.defaultMenuImage,
                                        title: recipe.title)
                        }
                    }
                    
                )
            }
            .navigationBarTitle(Constants.String.recipeTitleName)
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(
                trailing: Button(action: {
                    addRecipeIsShowing = true
                }) {
                    Image(systemName: "plus.app")
                })
        }.sheet(isPresented: $addRecipeIsShowing) {
            AddRecipeView(addRecipeIsShowing: $addRecipeIsShowing)
        }
        .task { @MainActor in
            if let recipe = recipeList.first, let image = recipe.image {
                selectedImage = UIImage(data: image)
            }
        }
    }
}

struct MyRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        MyRecipeView()
    }
}

