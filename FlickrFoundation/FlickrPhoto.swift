//
//  FlickrPhoto.swift
//  FlickrFoundation
//
//  Created by Haoxin Li on 3/1/19.
//  Copyright © 2019 Haoxin Li. All rights reserved.
//

import Foundation

public struct FlickrPhoto: Decodable {
    public let title: String
    public let url: URL

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case secret
        case server
        case farm
        case title
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)

        let farm = try container.decode(Int.self, forKey: .farm)
        let server = try container.decode(String.self, forKey: .server)
        let identifier = try container.decode(String.self, forKey: .identifier)
        let secret = try container.decode(String.self, forKey: .server)

        // See documentation here: https://www.flickr.com/services/api/misc.urls.html
        var components = URLComponents()
        components.scheme = "https"
        components.host = "farm\(farm).staticflickr.com"
        components.path = "/\(server)/\(identifier)_\(secret).jpg"

        guard let url = components.url else {
            let errorMessage = "Unable to construct a valid URL for the photo"
            throw DecodingError.valueNotFound(URL.self, DecodingError.Context(codingPath: [], debugDescription: errorMessage))
        }

        self.url = url
    }
}
