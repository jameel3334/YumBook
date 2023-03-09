//
//  CategoryModel.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/4/23.
//

import SwiftUI

extension TotalCategory: Equatable {
    static func == (lhs: TotalCategory, rhs: TotalCategory) -> Bool {
        return lhs.categories == rhs.categories
    }
}

struct TotalCategory: Codable {
    let categories: [Category]
}

struct Category: Codable, Equatable, Identifiable {
    let id: String
    let categoryTitle: String
    let image: String
    let categoryDescription: String
    
    enum CodingKeys: String, CodingKey  {
        case id = "idCategory"
        case categoryTitle = "strCategory"
        case image = "strCategoryThumb"
        case categoryDescription = "strCategoryDescription"
    }
}
