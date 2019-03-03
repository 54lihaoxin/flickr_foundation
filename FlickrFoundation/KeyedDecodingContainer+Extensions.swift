//
//  KeyedDecodingContainer+Extensions.swift
//  FlickrFoundation
//
//  Created by Haoxin Li on 3/2/19.
//  Copyright © 2019 Haoxin Li. All rights reserved.
//

import Foundation

// original gist: https://gist.github.com/54lihaoxin/f1271b73e0c1f2650e823949baf35a4c

extension KeyedDecodingContainer {

    /// The sole purpose of this `EmptyDecodable` is allowing decoder to skip an element that cannot be decoded.
    private struct EmptyDecodable: Decodable {}

    /// Return successfully decoded elements even if some of the element fails to decode.
    func safelyDecodeArray<T: Decodable>(of type: T.Type, forKey key: KeyedDecodingContainer.Key) -> [T] {
        guard var container = try? nestedUnkeyedContainer(forKey: key) else {
            return []
        }
        var elements = [T]()
        elements.reserveCapacity(container.count ?? 0)
        while !container.isAtEnd {
            /*
             Note:
             When decoding an element fails, the decoder does not move on the next element upon failure, so that we can retry the same element again
             by other means. However, this behavior potentially keeps `while !container.isAtEnd` looping forever, and Apple does not offer a `.skipFailable`
             decoder option yet. As a result, `catch` needs to manually skip the failed element by decoding it into an `EmptyDecodable` that always succeed.
             See the Swift ticket https://bugs.swift.org/browse/SR-5953.
             */
            do {
                elements.append(try container.decode(T.self))
            } catch {
                if let decodingError = error as? DecodingError {
                    print("\(#function): skipping one element: \(decodingError)")
                } else {
                    print("\(#function): skipping one element: \(error)")
                }
                _ = try? container.decode(EmptyDecodable.self) // skip the current element by decoding it into an empty `Decodable`
            }
        }
        return elements
    }
}
