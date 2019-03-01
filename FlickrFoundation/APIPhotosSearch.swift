//
//  APIPhotosSearch.swift
//  FlickrFoundation
//
//  Created by Haoxin Li on 3/1/19.
//  Copyright © 2019 Haoxin Li. All rights reserved.
//

import Foundation

struct APIPhotosSearch {
    struct Request {
        let searchTerm: String
    }

    struct Response {
        let pageNumber: Int
        let resultsPerPage: Int
        let totalPageCount: Int
        let totalResultCount: String // Flickr API doesn't use Int for some reason
        let photos: [FlickrPhoto]
    }

    static func performSearch(request: Request, completion: @escaping (ServiceResult<Response>) -> Void) {
        let urlString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(APIConstant.flickrAPIKey)&text=\(request.searchTerm.percentEncodedUrlQueryString)&per_page=\(APIConstant.resultsPerPage)&format=json&nojsoncallback=1" // TODO: need URL builder

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

            guard let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) else {
                completion(.failure(error: .decodeFailure))
                return
            }

            completion(.success(result: decodedResponse))
        }.resume()
    }
}

extension APIPhotosSearch.Response: Decodable {
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
