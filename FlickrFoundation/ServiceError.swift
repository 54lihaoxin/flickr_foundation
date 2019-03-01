//
//  ServiceError.swift
//  FlickrFoundation
//
//  Created by Haoxin Li on 3/1/19.
//  Copyright © 2019 Haoxin Li. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case invalidURL
    case noData
    case decodeFailure
    case unexpectedError(error: Error)
}
