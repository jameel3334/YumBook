//
//  TabViews.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/4/23.
//

import SwiftUI

struct TabViews: View {
    @EnvironmentObject var viewModel: FavoriteViewModel
    var body: some View {
        TabView {
            CategoryView()
                .tabItem {
                    Image(systemName: "book.closed")
                    Text("Book")
                }
                .tag(0)
            MyRecipeView()
                .tabItem {
                    Image(systemName: "book")
                    Text("My Book")
                }
                .tag(1)
            FavoriteView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorite")
                }
                .tag(2)
                .badge(viewModel.addedItems.count)
        }
    }
}

