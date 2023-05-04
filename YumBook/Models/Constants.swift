//
//  Contants.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/4/23.
//

import SwiftUI

enum Constants {
    enum General {
        public static let roundedSymbolDimensions: CGFloat = 30.0
        public static let roundedTextDimensions: CGFloat = 46.0
        public static let constraintsLeftRight: CGFloat = 30.0
        public static let constraintsTopBottom: CGFloat = 10.0
        public static let roundedStrokeWidth: CGFloat = 3.0
        public static let roundedBuyStrokeWidth: CGFloat = 6.0
        public static let cornerRadius: CGFloat = 12.0
        public static let greaterCornerRadius: CGFloat = 22.0
        public static let opacityBackground: CGFloat = 0.3
    }
    enum Color {
        public static let textColor = "textViewColor"
        public static let accentColor = "AccentColor"
    }
    enum Image {
        public static let mobileAppImage = "mainStart"
        public static let leftSpoonAppImage = "leftSpoonStart"
        public static let menuTileHeightWidth: CGFloat = 80.0
        public static let menuTileCornerRadius: CGFloat = 12.0
        public static let portraitViewImageDimensions: CGFloat = 350.0
        public static let landscapeViewImageDimensions: CGFloat = 200.0
        public static let defaultMenuImage = "defaultMenuImage"
    }
    enum URL {
        public static let callMenus = "https://www.themealdb.com/api/json/v1/1/filter.php?c="
        public static let callCategoryURL = "https://www.themealdb.com/api/json/v1/1/categories.php"
        public static let callMeal = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
    }
    enum String {
        public static let menuTitleName = "Menu"
        public static let categoriesTitleName = "Categories"
        public static let recipeTitleName = "My Recipes"
        public static let favoritesTitleName = "Favorites"
        public static let instTitleName = "Instructions"
        public static let instAndMeasureTitleName = "Ingredients - Measurements"
        public static let tapForIng = "Tap me for Ingredients"
    }
    enum Font {
        public static let comicText = "ComicNeue-Regular"
    }
}
