//
//  AddRecipeView.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 5/3/23.
//

import SwiftUI
import UIKit
import CoreML
import Vision

struct AddRecipeView: View {
    @State private var recipeName = ""
    @State private var ingredients = ""
    @State private var instructions = ""
    @State private var categories = ""
    @State private var selectedImage: UIImage? = nil
    @Environment(\.managedObjectContext) var viewContext
    @State private var isShowingImagePicker = false

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
                Section(header: Text("Image")) {
                             Button(action: {
                                 isShowingImagePicker = true
                             }) {
                                 Text("Select Image")
                             }
                             if let image = selectedImage {
                                 Image(uiImage: image)
                                     .resizable()
                                     .scaledToFit()
                             }
                         }
                Section {
                    if !self.recipeName.isEmpty {
                        Button(action:  {
                            Recipe.create(title: self.recipeName, instruction: self.instructions, ingredientAndMeasure: self.ingredients, image: self.selectedImage, in: self.viewContext)
                        addRecipeIsShowing = false
                        }) {
                            Text("Save Recipe")
                        }
                    }
                }
            }
            .navigationTitle("Add Recipe")
            .sheet(isPresented: $isShowingImagePicker) {
                      ImagePicker(selectedImage: $selectedImage)
                  }
              }
        }
    }



