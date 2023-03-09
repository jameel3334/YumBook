//
//  FavoriteView.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/8/23.
//

import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var viewModel: FavoriteViewModel
    var body: some View {
        NavigationView {
            Form {
                ForEach(viewModel.addedItems, id: \.id) { meal in
                    NavigationLink(
                        destination:
                            DetailedMealView(id: meal.id)
                        ,
                        label: {
                            ListRowView(imageURL: meal.image, title: meal.title)
                        })
                }
                .onDelete(perform: viewModel.remove)
            }
            .navigationBarTitle("Favorites".uppercased())
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                EditButton()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
