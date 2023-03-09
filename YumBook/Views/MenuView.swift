//
//  HomeView.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/4/23.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.managedObjectContext) var viewContext
    @StateObject var viewModel = MenuViewModel()
    let category: String
    var body: some View {
        List(viewModel.meals.sorted { $0.title < $1.title }, id: \.id) { meal in
            NavigationLink(
                destination:
                    DetailedMealView(id: meal.id)
                ,
                label: {
                    ListRowView(imageURL: meal.image, title: meal.title)
                })
        }
        .navigationBarTitle(Constants.String.menuTitleName)
        .accessibilityIdentifier("MenuTitle")
        .navigationBarTitleDisplayMode(.large)
        .navigationViewStyle(StackNavigationViewStyle())
        .task {
            viewModel.fetchMenus(for: category)
        }
    }
}

