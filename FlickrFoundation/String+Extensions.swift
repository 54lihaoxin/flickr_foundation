//
//  String+Extensions.swift
//  FlickrFoundation
//
//  Created by Haoxin Li on 3/1/19.
//  Copyright © 2019 Haoxin Li. All rights reserved.
//

import Foundation

extension String {
    var percentEncodedUrlQueryString: String {
        guard let string = addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            assertionFailure("\(#function) percent encoding failed for [\(self)]")
            return ""
        }
        return string
    }
}
