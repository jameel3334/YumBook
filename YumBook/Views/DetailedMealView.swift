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
    @EnvironmentObject var favoriteModel: FavoriteViewModel
    @State private var isFavorite = false
    @State private var ingredientsIsShowing: Bool = false
    let id: String
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
                            HStack {
                                HeaderText(text: meal.title)
                                    .multilineTextAlignment(.trailing)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding()
                                Spacer()
                                AddToFavorite(isFavorite: $isFavorite, meal: meal)
                                    .padding()
                            }
                            Divider()
                            LabelText(text: meal.instructions)
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding()
                            
                            Button("Show Popup") {
                                ingredientsIsShowing = true
                            }
                        }
                        .sheet(isPresented: $ingredientsIsShowing) {
                            IngredientsView(id: meal.id)
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
            } else if (verticalSizeClass == .compact && (horizontalSizeClass == . regular || horizontalSizeClass == .compact)) {
                ScrollView {
                    HStack {
                        ForEach(viewModel.meals, id: \.id) { meal in
                            VStack {
                                DetailedImageView(imageURL: meal.image)
                                    .frame(width: Constants.Image.portraitViewImageDimensions, height: Constants.Image.portraitViewImageDimensions)
                                    .cornerRadius(Constants.Image.menuTileCornerRadius)
                                Divider()
                                HStack {
                                    HeaderText(text: meal.title)
                                        .multilineTextAlignment(.trailing)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .padding()
                                    Spacer()
                                    AddToFavorite(isFavorite: $isFavorite, meal: meal)
                                        .padding()
                                }
                            }
                            VStack {
                                Divider()
                                LabelText(text: meal.instructions)
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding()
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
                }
            }
        }
    }
}

struct AddToFavorite: View {
    @EnvironmentObject var viewmodel:FavoriteViewModel
    @Binding var isFavorite: Bool
    var meal: Meal
    var body: some View {
        Button(action:  {
            
            self.isFavorite.toggle()
            
            if self.isFavorite {
                self.viewmodel.add(addedItem: meal)
            } else {
                self.viewmodel.undo(addedItem: meal)
            }
        }) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundColor(isFavorite ? .red : .gray)
        }
        .padding(.vertical, 10)
    }
}







