//
//  PaginationKitServerTests.swift
//  
//
//  Created by James Wolfe on 25/03/2023.
//

import XCTest
@testable import PaginationKitServer

final class PaginationKitServerTests: XCTestCase {

    // MARK: - Variables
    let paginator = Paginator<TestEncodable>(
        data: .init(repeating: .init(name: "Test"), count: 35)
    )
    
    // MARK: - Tests
    func testPageCount() {
        let pages = [1, 2, 3]
            .compactMap { paginator.paginate($0) }
        
        guard pages.count == 3 else {
            XCTFail("Invalid page count: \(pages.count)")
            return
        }
    }
    
    func testFirstPage() {
        guard let page = paginator.paginate(1) else {
            XCTFail("Null page value")
            return
        }
        
        guard page.currentPage == 1 else {
            XCTFail("Invalid current page value: \(page.currentPage)")
            return
        }
        
        guard page.data.count == 15 else {
            XCTFail("Invalid page count: \(page.data.count)")
            return
        }
        
        guard page.from == 1 else {
            XCTFail("Invalid from value: \(page.from)")
            return
        }
        
        guard page.lastPage == 3 else {
            XCTFail("Invalid last page value: \(page.lastPage)")
            return
        }
        
        guard page.perPage == 15 else {
            XCTFail("Invalid per page value: \(page.perPage)")
            return
        }
        
        guard page.to == 15 else {
            XCTFail("Invalid to value: \(page.to)")
            return
        }
        
        guard page.total == 35 else {
            XCTFail("Invalid total value: \(page.total)")
            return
        }
        
        guard page.hasNextPage else {
            XCTFail("Invalid next page value: \(page.hasNextPage ? "true": "false")")
            return
        }
    }
    
    func testSecondPage() {
        guard let page = paginator.paginate(2) else {
            XCTFail("Null page value")
            return
        }
        
        guard page.currentPage == 2 else {
            XCTFail("Invalid current page value: \(page.currentPage)")
            return
        }
        
        guard page.data.count == 15 else {
            XCTFail("Invalid page count: \(page.data.count)")
            return
        }
        
        guard page.from == 15 else {
            XCTFail("Invalid from value: \(page.from)")
            return
        }
        
        guard page.lastPage == 3 else {
            XCTFail("Invalid last page value: \(page.lastPage)")
            return
        }
        
        guard page.perPage == 15 else {
            XCTFail("Invalid per page value: \(page.perPage)")
            return
        }
        
        guard page.to == 30 else {
            XCTFail("Invalid to value: \(page.to)")
            return
        }
        
        guard page.total == 35 else {
            XCTFail("Invalid total value: \(page.total)")
            return
        }
        
        guard page.hasNextPage else {
            XCTFail("Invalid next page value: \(page.hasNextPage ? "true": "false")")
            return
        }
    }
    
    func testThirdPage() {
        guard let page = paginator.paginate(3) else {
            XCTFail("Null page value")
            return
        }
        
        guard page.currentPage == 3 else {
            XCTFail("Invalid current page value: \(page.currentPage)")
            return
        }
        
        guard page.data.count == 5 else {
            XCTFail("Invalid page count: \(page.data.count)")
            return
        }
        
        guard page.from == 30 else {
            XCTFail("Invalid from value: \(page.from)")
            return
        }
        
        guard page.lastPage == 3 else {
            XCTFail("Invalid last page value: \(page.lastPage)")
            return
        }
        
        guard page.perPage == 15 else {
            XCTFail("Invalid per page value: \(page.perPage)")
            return
        }
        
        guard page.to == 35 else {
            XCTFail("Invalid to value: \(page.to)")
            return
        }
        
        guard page.total == 35 else {
            XCTFail("Invalid total value: \(page.total)")
            return
        }
        
        guard !page.hasNextPage else {
            XCTFail("Invalid next page value: \(page.hasNextPage ? "true": "false")")
            return
        }
    }
    
    func testInvalidPage() {
        let page = paginator.paginate(4)
        
        guard page == nil else {
            XCTFail("Page should be null")
            return
        }
    }
    
}
