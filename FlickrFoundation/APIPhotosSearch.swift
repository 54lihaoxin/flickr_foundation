//
//  APIPhotosSearch.swift
//  FlickrFoundation
//
//  Created by Haoxin Li on 3/1/19.
//  Copyright © 2019 Haoxin Li. All rights reserved.
//

import Foundation

struct APIPhotosSearch {
    static func searchWithString(_ input: String, completion: @escaping (ServiceResult<PhotosSearchResponse>) -> Void) {
        let urlString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(APIConstant.flickrAPIKey)&text=\(input.percentEncodedUrlQueryString)&per_page=\(APIConstant.resultsPerPage)&format=json&nojsoncallback=1" // TODO: need URL builder

        guard let url = URL(string: urlString) else {
            completion(.failure(error: .invalidURL(urlString: urlString)))
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error: .unexpectedError(error: error)))
                return
            }

            guard let data = data, !data.isEmpty else {
                completion(.failure(error: .noData))
                return
            }

            guard let decodedResponse = try? JSONDecoder().decode(PhotosSearchResponse.self, from: data) else {
                completion(.failure(error: .decodeFailure))
                return
            }

            completion(.success(result: decodedResponse))
        }.resume()
    }
}
