//
//  NetworkConstants.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 23/06/2022.
//

import Foundation

enum NetworkConstants {
    enum Range {
        static let statusCode = 200...299
    }
    
    static let createdStatusCode = 2001
    static let retries: Int = 3
    static let baseUrl: String = getBaseUrl()
    
    static let timeoutIntervalForRequest: Double = 120
    
    private static func getBaseUrl() -> String {
        let scheme = EnvironmentManager.shared.string(key: .serverScheme)
        let host = EnvironmentManager.shared.string(key: .serverHost)
        
        return "\(scheme)://\(host)"
    }
    
    static let imageURL = EnvironmentManager.shared.string(key: .imageURL)
}
