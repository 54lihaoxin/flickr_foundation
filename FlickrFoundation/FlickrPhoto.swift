//
//  FlickrPhoto.swift
//  FlickrFoundation
//
//  Created by Haoxin Li on 3/1/19.
//  Copyright © 2019 Haoxin Li. All rights reserved.
//

import Foundation

struct FlickrPhoto {
    let identifier: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
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
