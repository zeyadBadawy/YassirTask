//
//  MockData.swift
//  YassirTaskTests
//
//  Created by Zeyad Badawy on 26/06/2022.
//

@testable import YassirTask

enum MockData {
    static let singleMovie = MovieData(
        id: Int.random(in: 0..<10000),
        adult: false,
        backdropPath: nil,
        genres: nil,
        originalLanguage: nil,
        originalTitle: nil,
        overview: nil,
        popularity: nil,
        posterPath: nil,
        releaseDate: nil,
        title: "Movie",
        video: nil,
        voteAverage: 3.5,
        voteCount: 5
    )
    
    static let moviesData: [MovieData] = Array(repeating: singleMovie, count: 40)
    
    static let moviesResponse = MoviesResponse(
        page: 1,
        results: moviesData,
        totalPages: 10,
        totalResults: 5
    )
    
    static let unexpectedError: BaseError = ErrorResolver.shared.getError(for: .unexpected)
    
    static let invalidMapping = ErrorResolver.shared.getError(for: .mapping)
    
    static let posterPath: String = "/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg"
}
