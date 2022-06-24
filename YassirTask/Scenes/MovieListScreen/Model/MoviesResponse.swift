//
//  MoviesResponse.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 23/06/2022.
//

import Foundation

struct MoviesResponse: Decodable {
    let page: Int?
    let results: [MovieData]?
    let totalPages: Int?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    init(
        page: Int? = nil,
        results: [MovieData]?,
        totalPages: Int?,
        totalResults: Int? = nil
    ) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}
