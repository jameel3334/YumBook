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
    var body: some View {
            NavigationView {
                List (recipeList, id: \.self) { recipe in
                    NavigationLink(
                        destination: MyRecipeDetailedView(recipe: recipe)
                        ,label: {
                            ListRowView(imageURL: Constants.Image.defaultMenuImage,
                                        title: recipe.title)
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
        }
    }

struct MyRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        MyRecipeView()
    }
}

