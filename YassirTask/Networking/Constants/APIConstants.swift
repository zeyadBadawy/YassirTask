//
//  APIConstants.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 23/06/2022.
//

import Foundation

enum APIConstants: String, CaseIterable {
    case discoverMovies = "/3/discover/movie?page=%@"
    case movieDetails = "/3/movie/%@?"
}
