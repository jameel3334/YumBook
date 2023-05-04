//
//  AddRecipeView.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 5/3/23.
//

import SwiftUI

struct AddRecipeView: View {
    @State private var recipeName = ""
    @State private var ingredients = ""
    @State private var instructions = ""
    @State private var categories = ""
    @Environment(\.managedObjectContext) var viewContext
    @Binding var addRecipeIsShowing: Bool
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Recipe Details")) {
                    TextField("Recipe Name", text: $recipeName)
                    TextField("Ingredients", text: $ingredients)
                    TextField("instructions", text: $instructions)
                    
                }
                Section(header: Text("Categories")) {
                    TextField("Enter categories separated by commas", text: $categories)
                }
                Section {
                    if !self.recipeName.isEmpty {
                        Button(action:  {
                            Recipe.create(title: self.recipeName, instruction: self.instructions, ingredientAndMeasure: self.ingredients, in: self.viewContext)
                        addRecipeIsShowing = false
                        }) {
                            Text("Save Recipe")
                        }
                    }
                }
            }
            .navigationTitle("Add Recipe")
        }
    }
}


