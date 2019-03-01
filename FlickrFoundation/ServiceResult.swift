//
//  ServiceResult.swift
//  FlickrFoundation
//
//  Created by Haoxin Li on 3/1/19.
//  Copyright © 2019 Haoxin Li. All rights reserved.
//

import Foundation

enum ServiceResult<T> {
    case success(result: T)
    case failure(error: ServiceError)
}
