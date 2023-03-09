//
//  NetworkManager.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/5/23.
//

import SwiftUI

class NetworkManager: ObservableObject {
    
    static let instance = NetworkManager()
    let service: APIServiceProtocol
    
    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }
}
