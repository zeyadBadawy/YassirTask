//
//  MovieData.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 23/06/2022.
//

import Foundation

struct MovieData: Decodable {
    let id: Int
    let adult: Bool?
    let backdropPath: String?
    let genres: [genre]?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genres = "genres"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension MovieData {
    var posterFullURL: String? {
        guard let posterPath: String = posterPath else { return nil }
        return NetworkConstants.imageURL + ImageSize.w500.rawValue + posterPath
    }
}

struct genre:Decodable {
    let id:Int?
    let name:String?
}
