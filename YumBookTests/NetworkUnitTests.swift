//
//  NetworkUnitTests.swift
//  YumBookTests
//
//  Created by Mohammed Jameeluddin on 3/4/23.
//

import XCTest
@testable import YumBook

final class NetworkUnitTests: XCTestCase {
    private var session: URLSession!
    private var url: URL!
    
    override func setUp() {
        url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        session = URLSession(configuration: configuration)
    }
    
    override func tearDown() {
        url = nil
        session = nil
        super.tearDown()
    }
    
    func test_jsonDecodes_success() {
        XCTAssertNoThrow(try JSONMapper.decode(file: "Categories", type: TotalCategory.self), "Mapper shouldn't throw an error")
        let categoryResponse = try? JSONMapper.decode(file: "Categories", type: TotalCategory.self)
        XCTAssertNotNil(categoryResponse, "User response shouldn't be nil")
        XCTAssertEqual(categoryResponse?.categories.count, 6)
        XCTAssertEqual(categoryResponse?.categories[0].id, "1")
        XCTAssertEqual(categoryResponse?.categories[5].image, "https://www.themealdb.com/images/category/pasta.png")
        XCTAssertEqual(categoryResponse?.categories[2].categoryTitle, "Dessert")
        XCTAssertEqual(categoryResponse?.categories[1].categoryDescription, "Chicken is a type of domesticated fowl, a subspecies of the red junglefowl. It is one of the most common and widespread domestic animals, with a total population of more than 19 billion as of 2011.[1] Humans commonly keep chickens as a source of food (consuming both their meat and eggs) and, more rarely, as pets.")
    }
    
    func test_successfulResponse_code() async throws {
        
        guard let path = Bundle.main.path(forResource: "Categories", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get the static users file")
            return
        }
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, data)
        }
        let dataResponse = try await MockAPIServiceManager.shared.request(session: session,
                                                                          from: "Dummy",
                                                                          type: TotalCategory.self)
        let staticJSON = try JSONMapper.decode(file: "Categories",
                                               type: TotalCategory.self)
        
        XCTAssertEqual(dataResponse.categories, staticJSON.categories)
    }
    
    func test_unsuccessfulResponse_code() async  {
        let invalidStatusCode = 400
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: invalidStatusCode,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        do {
            _ = try await MockAPIServiceManager.shared.request(session: session,
                                                               from: "Dummy",
                                                               type: TotalCategory.self)
        } catch {
            guard let networkingError = error as? NetworkingError else {
                XCTFail("Got the wrong type of error, expecting NetworkingManager NetworkingError")
                return
            }
            XCTAssertEqual(networkingError,
                           NetworkingError.invalidStatusCode(statusCode: invalidStatusCode),
                           "Error should be a networking error which throws an invalid status code")
        }
    }
}



