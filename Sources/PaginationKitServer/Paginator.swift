//
//  Paginator.swift
//  
//
//  Created by James Wolfe on 25/03/2023.
//

import Foundation

public struct Paginator<T: Encodable> {
    
    // MARK: - Variables
    public let data: [T]
    
    // MARK: - Utilities
    public func paginate(_ page: Int) -> PaginatedResponse<T>? {
        let pages = data.chunked(into: 15)
        guard pages.indices.contains(page - 1), data.count > 0 else { return nil }
        return .init(
            currentPage: page,
            data: pages[page - 1],
            from: page == 1 ? 1 : ((page - 1) * 15),
            lastPage: pages.count,
            perPage: 15,
            to: ((page - 1) * 15) + pages[page - 1].count,
            total: data.count
        )
    }
    
}
