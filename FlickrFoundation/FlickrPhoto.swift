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
    var url: URL? {
        return url(withQualitySpecifier: .unspecified)
    }

    func thumbnailURL(forScreenScale scale: CGFloat) -> URL? {
        let qualitySpecifier: QualitySpecifier
        if scale >= 3 {
            qualitySpecifier = .longestSide320
        } else if scale >= 2 {
            qualitySpecifier = .longestSide240
        } else { // scale == 1
            qualitySpecifier = .square150x150
        }
        return url(withQualitySpecifier: qualitySpecifier)
    }
}

private extension FlickrPhoto {
    enum QualitySpecifier: String {
        case unspecified = "" // no specifier
        case longestSide320 = "_n" // n: 320 on longest side
        case longestSide240 = "_m" // m: 240 on longest side
        case square150x150 = "_q" // q: square 150x150
    }

    /**
     See documentation here: https://www.flickr.com/services/api/misc.urls.html
     */
    func url(withQualitySpecifier qualitySpecifier: QualitySpecifier) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "farm\(farm).staticflickr.com"
        components.path = "/\(server)/\(identifier)_\(secret)\(qualitySpecifier.rawValue).jpg"
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
