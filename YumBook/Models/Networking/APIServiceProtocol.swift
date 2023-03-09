//
//  APIServiceProtocol.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/5/23.
//

import SwiftUI

protocol APIServiceProtocol {
    func fetchData<T: Codable>(from urlString: String, for type: T.Type) async throws -> T
}
