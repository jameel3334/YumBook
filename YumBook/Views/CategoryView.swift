//
//  CategoryView.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/4/23.
//

import SwiftUI

struct CategoryView: View {
    @StateObject var viewModel = CategoryViewModel()
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
            .navigationBarTitle("Categories".uppercased())
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                viewModel.fetchDessertMeals()
            }
        }
    }
}
