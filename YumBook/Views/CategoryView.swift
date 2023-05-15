//
//  CategoryView.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/4/23.
//

import SwiftUI

struct CategoryView: View {
    @StateObject var viewModel = CategoryViewModel()
    @EnvironmentObject private var networkState: NetworkMonitor
    var body: some View {
        NavigationView {
            List (viewModel.categories) { category in
                NavigationLink(
                    destination:
                        MenuView(category: category.categoryTitle)
                    ,label: {
                        ListRowView(imageURL: category.image,
                                    title: category.categoryTitle.replacingOccurrences(of: "Pork", with: "Steak"))
                    }
                )
            }
            .navigationBarTitle(Constants.String.categoriesTitleName)
            .navigationBarTitleDisplayMode(.large)
            .alert(isPresented: $networkState.isNotActive) {
                Alert(title: Text("No internet connection"), message:
                        Text("Please check your network connection")
                      , dismissButton: .default(Text("OK")))
            }
            .onAppear {
                viewModel.fetchDessertMeals()
            }
        }
    }
}
