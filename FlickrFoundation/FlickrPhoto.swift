//
//  FlickrPhoto.swift
//  FlickrFoundation
//
//  Created by Haoxin Li on 3/1/19.
//  Copyright © 2019 Haoxin Li. All rights reserved.
//

import Foundation

public struct FlickrPhoto {
    public let identifier: String
    public let title: String

    let owner: String
    let secret: String
    let server: String
    let farm: Int
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
