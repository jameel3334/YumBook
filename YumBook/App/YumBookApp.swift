//
//  YumBookApp.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/4/23.
//

import SwiftUI

@main
struct YumBookApp: App {
    @StateObject var viewModelFavourite = FavoriteViewModel()
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(viewModelFavourite)
        }
    }
}
