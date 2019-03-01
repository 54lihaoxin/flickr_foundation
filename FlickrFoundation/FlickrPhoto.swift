//
//  FlickrPhoto.swift
//  FlickrFoundation
//
//  Created by Haoxin Li on 3/1/19.
//  Copyright © 2019 Haoxin Li. All rights reserved.
//

import Foundation

public struct FlickrPhoto {
    public let title: String

    let identifier: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
}

public extension FlickrPhoto {
    /**
     See documentation here: https://www.flickr.com/services/api/misc.urls.html
     */
    public var sourceURL: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "farm\(farm).staticflickr.com"
        components.path = "/\(server)/\(identifier)_\(secret).jpg"
        return components.url
    }
}

extension FlickrPhoto: Decodable {
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case owner
        case secret
        case server
        case farm
        case title
    }
}
