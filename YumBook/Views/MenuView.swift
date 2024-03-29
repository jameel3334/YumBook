//
//  HomeView.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/4/23.
//

import SwiftUI

struct MenuView: View {
    @StateObject var viewModel = MenuViewModel()
    let category: String
    var body: some View {
        List(viewModel.meals.sorted { $0.title < $1.title }, id: \.id) { meal in
            NavigationLink(
                destination:
                    DetailedMealView(id: meal.id)
                ,
                label: {
                    ListRowView(imageURL: meal.image, title: meal.title.replacingOccurrences(of: "\\bPork\\b", with: "Steak", options: .regularExpression))
                })
        }
        .navigationBarTitle(Constants.String.menuTitleName)
        .navigationBarTitleDisplayMode(.large)
        .navigationViewStyle(StackNavigationViewStyle())
        .task {
            viewModel.fetchMenus(for: category)
        }
    }
}

