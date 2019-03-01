//
//  KeywordSearchManagerTests.swift
//  FlickrFoundationTests
//
//  Created by Haoxin Li on 3/1/19.
//  Copyright © 2019 Haoxin Li. All rights reserved.
//

import XCTest
@testable import FlickrFoundation

final class KeywordSearchManagerTests: XCTestCase {
    private let networkTimeout: TimeInterval = 3

    func testHotRequest() {
        let expectation = self.expectation(description: "search for photos")
        let manager = KeywordSearchManager()
        manager.searchPhotos(searchTerm: "red apple", pageNumber: 1) { result in
            switch result {
            case let .success(photos, totalPageCount):
                print("\(#function) result.photos.count: \(photos.count), totalPageCount: \(totalPageCount)")
            case let .failure(errorMessage):
                XCTFail(errorMessage)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: networkTimeout, handler: nil)
    }
}
