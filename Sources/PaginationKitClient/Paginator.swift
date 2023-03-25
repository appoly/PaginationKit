//
//  Paginator.swift
//  
//
//  Created by James Wolfe on 24/03/2023.
//

import SwiftUI

public class Paginator<T: Decodable>: ObservableObject {
    
    // MARK: - Variables
    @Published public var data: [T] = []
    
    public let fetch: (Int) async throws -> Data
    
    private(set) var hasNextPage: Bool = true
    private(set) var perPage: Int = .zero
    private(set) var page: Int = .zero
    private let decoder: JSONDecoder
    
    // MARK: - Initializers
    
    public init(fetch: @escaping (Int) async throws -> Data, decoder: JSONDecoder = .init()) async throws {
        self.fetch = fetch
        self.decoder = decoder
        try await next()
    }
    
    // MARK: - Utilities
    
    public func next() async throws {
        guard hasNextPage else { return }
        page += 1
        let results = try await decoder.decode(PaginatedResponse<T>.self, from: fetch(page))
        await MainActor.run { [weak self] in
            self?.data.append(contentsOf: results.data)
            self?.perPage = results.perPage
            self?.hasNextPage = results.hasNextPage
        }
    }
    
    public func previous() async throws {
        guard page > 1 else { return }
        data = data.dropLast(perPage * 2)
        page -= 2
        try await next()
    }
    
}
