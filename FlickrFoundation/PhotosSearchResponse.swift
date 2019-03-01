//
//  PhotosSearchResponse.swift
//  FlickrFoundation
//
//  Created by Haoxin Li on 3/1/19.
//  Copyright © 2019 Haoxin Li. All rights reserved.
//

import Foundation

struct PhotosSearchResponse {
    let pageNumber: Int
    let resultsPerPage: Int
    let totalPageCount: Int
    let totalResultCount: String // Flickr API doesn't use Int for some reason
    let photos: [FlickrPhoto]
}

extension PhotosSearchResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case photosRoot = "photos"
        case pageNumber = "page"
        case resultsPerPage = "perpage"
        case totalPageCount = "pages"
        case totalResultCount = "total"
        case photoArray = "photo"
    }

    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: CodingKeys.self)
        let container = try rootContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .photosRoot)
        pageNumber = try container.decode(Int.self, forKey: .pageNumber)
        totalPageCount = try container.decode(Int.self, forKey: .totalPageCount)
        resultsPerPage = try container.decode(Int.self, forKey: .resultsPerPage)
        totalResultCount = try container.decode(String.self, forKey: .totalResultCount)
        photos = try container.decode([FlickrPhoto].self, forKey: .photoArray)
    }
}
