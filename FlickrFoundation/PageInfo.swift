//
//  PageInfo.swift
//  FlickrFoundation
//
//  Created by Haoxin Li on 3/1/19.
//  Copyright © 2019 Haoxin Li. All rights reserved.
//

import Foundation

/// We need to bundle the page number and result count per page together because it's difficult to make sense with
/// just one of them.
struct PageInfo {
    let pageNumber: Int
    let resultsPerPage: Int
}
