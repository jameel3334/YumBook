//
//  APIService.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/5/23.
//

import SwiftUI

struct APIService: APIServiceProtocol {
    func fetchData<T: Codable >(from urlString: String, for type: T.Type) async throws -> T {
        guard let url = URL(string: urlString)
        else {
            throw NetworkingError.invalidUrl
        }
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
        let jsonData: T = try JSONDecoder().decode(T.self, from: data)
        return jsonData
    }
}
