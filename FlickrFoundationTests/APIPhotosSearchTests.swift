//
//  API_Photos_Search_tests.swift
//  FlickrFoundationTests
//
//  Created by Haoxin Li on 3/1/19.
//  Copyright © 2019 Haoxin Li. All rights reserved.
//

import XCTest
@testable import FlickrFoundation

final class APIPhotosSearchTests: XCTestCase {
    private let networkTimeout: TimeInterval = 5

    func testHotRequest() {
        let expectation = self.expectation(description: "search for photos")
        let request = APIPhotosSearch.Request(searchTerm: "red apple",
                                              pageInfo: PageInfo(pageNumber: 1, resultsPerPage: APIConstant.resultsPerPage))
        APIPhotosSearch.performSearch(request: request) { result in
            switch result {
            case let .success(result):
                print("\(#function) result.photos.count: \(result.photos.count)")
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: networkTimeout, handler: nil)
    }
}
