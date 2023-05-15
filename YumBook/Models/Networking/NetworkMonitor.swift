//
//  NetworkMonitor.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 5/15/23.
//

import Foundation
import Network

class NetworkMonitor: ObservableObject {
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    @Published var isNotActive = false
    
     init() {
        monitor.pathUpdateHandler = { path in
            Task { @MainActor in
                if path.status == .unsatisfied {
                    self.isNotActive = true
                } else if path.status == .satisfied {
                    self.isNotActive = false
                }
            }
        }
        monitor.start(queue: queue)
    }
}
