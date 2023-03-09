//
//  DetailedMealView.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/4/23.
//

import SwiftUI

struct DetailedMealView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @ObservedObject var viewModel = MealsViewModel()
    @State private var isFavorite = false
    @State private var ingredientsIsShowing: Bool = false
    var id: String
    var body: some View {
        ZStack {
            Color(Constants.Color.accentColor).opacity(Constants.General.opacityBackground)
                .ignoresSafeArea()
            
            if verticalSizeClass == .regular && horizontalSizeClass == .compact {
                ScrollView {
                    ForEach(viewModel.meals, id: \.id) { meal in
                        VStack {
                            DetailedImageView(imageURL: meal.image)
                                .frame(width: Constants.Image.portraitViewImageDimensions, height: Constants.Image.portraitViewImageDimensions)
                                .cornerRadius(Constants.Image.menuTileCornerRadius)
                            Divider()
                            SubHeaderText(text: meal.title.replacingOccurrences(of: "Pork", with: "Steak"))
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
                            LabelText(text: meal.instructions.replacingOccurrences(of: "Pork", with: "Steak"))
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding()
                                .toolbar {
                                    ToolbarItem(placement: .navigationBarTrailing) {
                                        AddToFavorite(isFavorite: $isFavorite, meal: meal)
                                    }
                                }
                        }
                        .sheet(isPresented: $ingredientsIsShowing) {
                            IngredientsView(ingredientsAndMeasures: meal.ingredientsAndMeasures)
                        }
                    }
                }
                
            } else if (verticalSizeClass == .compact && (horizontalSizeClass == . regular || horizontalSizeClass == .compact)) {
                ForEach(viewModel.meals, id: \.id) { meal in
                    HStack {
                        ScrollView {
                            VStack {
                                DetailedImageView(imageURL: meal.image)
                                    .scaledToFit()
                                    .frame(width: Constants.Image.landscapeViewImageDimensions, height: Constants.Image.landscapeViewImageDimensions)
                                    .cornerRadius(Constants.Image.menuTileCornerRadius)
                                Divider()
                                SubHeaderText(text: meal.title.replacingOccurrences(of: "Pork", with: "Steak"))
                                    .multilineTextAlignment(.leading)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding()
                                Spacer()
                                InfoButton(ingredientsIsShowing: $ingredientsIsShowing)
                                Spacer()
                            }
                        }
                        ScrollView {
                            VStack {
                                Divider()
                                SubHeaderText(text: Constants.String.instTitleName)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                LabelText(text: meal.instructions.replacingOccurrences(of: "Pork", with: "Steak"))
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding()
                            }
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    AddToFavorite(isFavorite: $isFavorite, meal: meal)
                                }
                            }
                        }
                        .sheet(isPresented: $ingredientsIsShowing) {
                            IngredientsView(ingredientsAndMeasures: meal.ingredientsAndMeasures)
                        }
                    }
                }
            }
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

struct AddToFavorite: View {
    @EnvironmentObject var viewModel:FavoriteViewModel
    @Binding var isFavorite: Bool
    var meal: Meal
    var body: some View {
        Button(action:  {
            self.isFavorite.toggle()
            if self.isFavorite {
                self.viewModel.add(addedItem: meal)
            } else {
                self.viewModel.undo(addedItem: meal)
            }
        }) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundColor(isFavorite ? .red : .gray)
        }
        .padding(.vertical, 10)
    }
}

struct InfoButton: View {
    @Binding var ingredientsIsShowing: Bool
    var body: some View {
        Button(action: {
            ingredientsIsShowing = true
        }) {
            HStack(spacing: nil){
                LabelText(text: Constants.String.tapForIng)
                    .multilineTextAlignment(.trailing)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Image(systemName: "info.circle")
            }
            .padding(.horizontal, Constants.General.constraintsTopBottom)
        }
    }
}







