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
                    Image(systemName: "book")
                    Text("Book")
                }
                .tag(0)
            FavoriteView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorite")
                }
                .tag(1)
                .badge(viewModel.addedItems.count)
        }
    }
}

