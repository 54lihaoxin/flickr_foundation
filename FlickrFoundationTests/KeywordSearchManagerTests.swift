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
        let manager = KeywordSearchManager(searchTerm: "red apple")
        manager.fetchMorePhotos { result in
            switch result {
            case .success:
                print("\(#function) manager.photos.count: \(manager.photos.count), manager.totalResultCount: \(manager.totalResultCount)")
            case let .failure(errorMessage):
                XCTFail(errorMessage)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: networkTimeout, handler: nil)
    }
}
