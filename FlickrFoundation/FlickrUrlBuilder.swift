//
//  FlickrUrlBuilder.swift
//  FlickrFoundation
//
//  Created by Haoxin Li on 3/1/19.
//  Copyright © 2019 Haoxin Li. All rights reserved.
//

import Foundation

struct FlickrUrlBuilder {
    static func urlForQuery(_ query: FlickrUrlQuery) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.flickr.com"
        components.path = "/services/rest"
        components.queryItems = commonQueryItems + query.queryItems
        return components.url
    }
}

private extension FlickrUrlBuilder {
    static var commonQueryItems: [URLQueryItem] {
        return [URLQueryItem(name: "api_key", value: APIConstant.flickrAPIKey)]
    }
}
