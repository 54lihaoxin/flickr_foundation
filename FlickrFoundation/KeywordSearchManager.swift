//
//  KeywordSearchManager.swift
//  FlickrFoundation
//
//  Created by Haoxin Li on 2/26/19.
//  Copyright © 2019 Haoxin Li. All rights reserved.
//

import Foundation

/**
 Each `KeywordSearchManager` is only good for one search term, and a new `KeywordSearchManager` is needed for new
 search term. Page status is managed internally, while pages are fetched consecutively upon request.
 */
public final class KeywordSearchManager {
    public enum SearchResult {
        case success
        case failure(errorMessage: String)
    }

    public let searchTerm: String
    public private(set) var totalResultCount = 0 // number of all results could be returned from backend API
    public private(set) var photos = [FlickrPhoto]()
    public private(set) var isFetchInProgress = false

    private var lastFetchedPageNumber = 0 // the first page is 1, not 0, so use 0 to represent "not fetched"
    private var totalPageCount = 0

    public init(searchTerm: String) {
        self.searchTerm = searchTerm
    }
}

// MARK: - API

public extension KeywordSearchManager {
    func fetchMorePhotos(completion: @escaping (SearchResult) -> Void) {
        guard !isFetchInProgress,
            !searchTerm.isEmpty,
            self.lastFetchedPageNumber <= totalPageCount else {
            return
        }

        let pageNumber = lastFetchedPageNumber + 1
        let request = APIPhotosSearch.Request(searchTerm: searchTerm,
                                              pageInfo: PageInfo(pageNumber: pageNumber,
                                                                 resultsPerPage: APIConstant.resultsPerPage))

        isFetchInProgress = true
        APIPhotosSearch.performSearch(request: request) { [weak self] result in
            guard let self = self else {
                return // do nothing if the user is searching for something different
            }

            defer {
                self.isFetchInProgress = false
            }

            switch result {
            case let .success(result):
                if self.photos.isEmpty { // set `totalResultCount` in the first fetch, and do not update later
                    self.totalResultCount = Int(result.totalResultCount) ?? result.photos.count
                }
                self.photos.append(contentsOf: result.photos)
                self.lastFetchedPageNumber = pageNumber
                self.totalPageCount = result.totalPageCount
                completion(.success)
            case let .failure(error):
                completion(.failure(errorMessage: error.localizedDescription))
            }
        }
    }
}
