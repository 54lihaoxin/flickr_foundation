//
//  KeywordSearchManager.swift
//  FlickrFoundation
//
//  Created by Haoxin Li on 2/26/19.
//  Copyright © 2019 Haoxin Li. All rights reserved.
//

import Foundation

public final class KeywordSearchManager {
    public enum SearchResult {
        case success(searchTerm: String, pageNumber: Int, photos: [FlickrPhoto], totalPageCount: Int)
        case failure(errorMessage: String)
    }

    public static let shared = KeywordSearchManager()

    private(set) var searchTerm = ""
    private(set) var pageNumber = 1 // the first page is 1, not 0
}

// MARK: - API

public extension KeywordSearchManager {
    func searchPhotos(searchTerm: String, pageNumber: Int, completion: @escaping (SearchResult) -> Void) {
        guard pageNumber > 0 else {
            completion(.failure(errorMessage: "Page number should start from 1"))
            return
        }

        self.searchTerm = searchTerm
        self.pageNumber = pageNumber

        let request = APIPhotosSearch.Request(searchTerm: searchTerm,
                                              pageInfo: PageInfo(pageNumber: pageNumber,
                                                                 resultsPerPage: APIConstant.resultsPerPage))
        APIPhotosSearch.performSearch(request: request) { [weak self] result in
            guard let self = self,
                self.searchTerm == searchTerm,
                self.pageNumber == pageNumber else {
                return // do nothing if the user is searching for something different
            }

            switch result {
            case let .success(result):
                completion(.success(searchTerm: searchTerm,
                                    pageNumber: pageNumber,
                                    photos: result.photos,
                                    totalPageCount: result.totalPageCount))
            case let .failure(error):
                completion(.failure(errorMessage: error.localizedDescription))
            }
        }
    }
}
