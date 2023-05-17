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
    @State private var ingredients: [String] = []
    @State private var ingredient = ""
    @State private var instructions: [String] = []
    @State private var instruction = ""
    @State private var selectedImage: UIImage? = nil
    @Environment(\.managedObjectContext) var viewContext
    @State private var isShowingImagePicker = false
    @Binding var addRecipeIsShowing: Bool
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Recipe Details")) {
                    TextField("Recipe Name", text: $recipeName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        TextField("Ingredient", text: $ingredient)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        Button(action: {
                            addIngredient()
                        }) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.blue)
                                Text("Add Ingredient")
                                    .foregroundColor(.blue)
                                    .font(.body)
                            }
                        }
                        List {
                            ForEach(ingredients, id: \.self) { ingredient in
                                Text(ingredient)
                            }
                            .onDelete(perform: deleteIngredient)
                        }
                        .frame(height: 40)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(8)

                    TextField("Instruction", text: $instruction)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button(action: {
                        addInstructions()
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.blue)
                            Text("Add Instruction")
                                .foregroundColor(.blue)
                                .font(.body)
                        }
                    }
                    List {
                        ForEach(instructions, id: \.self) { instruction in
                            Text(instruction)
                        }
                        .onDelete(perform: deleteInstructions)
                    }
                    .frame(height: 40)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(8)
                }
                
                Section(header: Text("Image")) {
                    Button(action: {
                        isShowingImagePicker = true
                    }) {
                        HStack {
                            Image(systemName: "photo")
                            Text("Select Image")
                        }
                        .foregroundColor(.blue)
                    }
                    
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(8)
                    }
                    
                    if selectedImage != nil {
                        Button(action: {
                            selectedImage = nil
                        }) {
                            Text("Clear Image")
                                .foregroundColor(.red)
                        }
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
                .padding()
            }
            .navigationBarTitle("Add Recipe")
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        addRecipeIsShowing = false
                    }) {
                        Text("Cancel")
                    }
                }
            }
        }
    }
    
    private func addIngredient() {
        ingredients.append(ingredient)
        ingredient = ""
    }
    
    private func deleteIngredient(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
    }
    
    private func addInstructions() {
        instructions.append(instruction)
        instruction = ""
    }
    
    private func deleteInstructions(at offsets: IndexSet) {
        instructions.remove(atOffsets: offsets)
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    @State static var addRecipeIsShowing = true
    
    static var previews: some View {
        AddRecipeView(addRecipeIsShowing: $addRecipeIsShowing)
    }
}



