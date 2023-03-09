//
//  MenuModel.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/7/23.
//

import SwiftUI

extension TotalMenu: Equatable {
    static func ==(lhs: TotalMenu, rhs: TotalMenu) -> Bool {
        return lhs.meals == rhs.meals
    }
}

struct TotalMenu: Codable {
    let meals: [Menu]
}

struct Menu: Codable, Equatable, Identifiable {
    let id: String
    let title: String
    let image: String
    enum CodingKeys: String, CodingKey {
        case image = "strMealThumb"
        case id = "idMeal"
        case title = "strMeal"
    }
}
