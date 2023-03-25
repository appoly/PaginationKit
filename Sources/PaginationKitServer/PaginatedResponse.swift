//
//  File.swift
//  
//
//  Created by James Wolfe on 24/03/2023.
//

import Foundation

public struct PaginatedResponse<T: Encodable>: Encodable {
    
    // MARK: - Variables
    public let currentPage: Int
    public let data: [T]
    public let from: Int
    public let lastPage: Int
    public let perPage: Int
    public let to: Int
    public let total: Int
    
    public var hasNextPage: Bool {
        lastPage != currentPage
    }

    // MARK: - Coding Keys
    private enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case from
        case lastPage = "last_page"
        case perPage = "per_page"
        case to, total
    }
    
}
