//
//  FlickrUrlQuery.swift
//  FlickrFoundation
//
//  Created by Haoxin Li on 3/1/19.
//  Copyright © 2019 Haoxin Li. All rights reserved.
//

import Foundation

struct FlickrUrlQuery {
    enum Method: String {
        case photosSearch = "flickr.photos.search"
    }

    let method: Method
    let pageInfo: PageInfo?
    let expectJsonResponse: Bool
    let parameters: [String: String]

    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem(name: "method", value: method.rawValue)]
        if let pageInfo = pageInfo {
            items.append(URLQueryItem(name: "page", value: "\(pageInfo.pageNumber)"))
            items.append(URLQueryItem(name: "per_page", value: "\(pageInfo.resultsPerPage)"))
        }
        if expectJsonResponse {
            items.append(URLQueryItem(name: "format", value: "json"))
            items.append(URLQueryItem(name: "nojsoncallback", value: "1"))
        }
        return items + parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
