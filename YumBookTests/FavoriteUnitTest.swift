//
//  FavoriteUnitTest.swift
//  YumBookTests
//
//  Created by Mohammed Jameeluddin on 3/8/23.
//

import XCTest
@testable import YumBook

class FavoriteUnitTest: XCTestCase {
    var favorite: FavoriteViewModel!
    var meal: Meal!
    
    override func setUpWithError() throws {
        favorite = FavoriteViewModel()
        meal = Meal(id: "", title: "", instructions: "", image: "", ingredients: "", measurements: "")
    }
    
    func testAddToFavorites() throws {
        XCTAssertEqual(favorite.addedItems.count, 0)
        favorite.add(addedItem: meal)
        XCTAssertEqual(favorite.addedItems.count, 1)
    }
    
    func testUndoFavorites() throws {
        favorite.add(addedItem: meal)
        XCTAssertEqual(favorite.addedItems.count, 1)
        favorite.undo(addedItem: meal)
        XCTAssertNotEqual(favorite.addedItems.count, 1)
    }
}
