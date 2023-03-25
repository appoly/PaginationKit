//
//  PaginationKitClientTests.swift
//
//
//  Created by James Wolfe on 25/03/2023.
//

import XCTest
@testable import PaginationKitClient
@testable import PaginationKitServer

final class PaginationKitClientTests: XCTestCase {
    
    // MARK: - Variables
    let serverPaginator = PaginationKitServer.Paginator<TestCodable>(
        data: .init(repeating: .init(name: "Test"), count: 35)
    )
    let decoder = JSONDecoder()
    
    // MARK: - Tests
    
    func testFirstPage() async throws {
        let page = try await PaginationKitClient.Paginator<TestCodable>(fetch: fetch(_:))
        
        guard page.page == 1 else {
            XCTFail("Invalid current page value: \(page.page)")
            return
        }
        
        guard page.data.count == 15 else {
            XCTFail("Invalid page count: \(page.data.count)")
            return
        }
        
        guard page.perPage == 15 else {
            XCTFail("Invalid per page value: \(page.perPage)")
            return
        }
        
        guard page.hasNextPage else {
            XCTFail("Invalid next page value: \(page.hasNextPage ? "true": "false")")
            return
        }
    }
    
    func testSecondPage() async throws {
        let page = try await PaginationKitClient.Paginator<TestCodable>(fetch: fetch(_:))
        try await page.next()
        
        guard page.page == 2 else {
            XCTFail("Invalid current page value: \(page.page)")
            return
        }
        
        guard page.data.count == 30 else {
            XCTFail("Invalid page count: \(page.data.count)")
            return
        }
        
        guard page.perPage == 15 else {
            XCTFail("Invalid per page value: \(page.perPage)")
            return
        }
        
        guard page.hasNextPage else {
            XCTFail("Invalid next page value: \(page.hasNextPage ? "true": "false")")
            return
        }
    }
    
    func testThirdPage() async throws {
        let page = try await PaginationKitClient.Paginator<TestCodable>(fetch: fetch(_:))
        try await page.next()
        try await page.next()
        
        guard page.page == 3 else {
            XCTFail("Invalid current page value: \(page.page)")
            return
        }
        
        guard page.data.count == 35 else {
            XCTFail("Invalid page count: \(page.data.count)")
            return
        }
        
        guard page.perPage == 15 else {
            XCTFail("Invalid per page value: \(page.perPage)")
            return
        }
        
        guard !page.hasNextPage else {
            XCTFail("Invalid next page value: \(page.hasNextPage ? "true": "false")")
            return
        }
    }
    
    func testInvalidPage() async throws {
        let page = try await PaginationKitClient.Paginator<TestCodable>(fetch: fetch(_:))
        try await page.next()
        try await page.next()
        try await page.next()
        
        guard page.page == 3 else {
            XCTFail("Invalid current page value: \(page.page)")
            return
        }
        
        guard page.data.count == 35 else {
            XCTFail("Invalid page count: \(page.data.count)")
            return
        }
        
        guard page.perPage == 15 else {
            XCTFail("Invalid per page value: \(page.perPage)")
            return
        }
        
        guard !page.hasNextPage else {
            XCTFail("Invalid next page value: \(page.hasNextPage ? "true": "false")")
            return
        }
    }
    
    // MARK: - Utilities
    private func fetch(_ page: Int) async throws -> Data {
        let page = serverPaginator.paginate(page)
        return try JSONEncoder().encode(page)
    }

}
