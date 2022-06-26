//
//  MovieDataEntity.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 26/06/2022.
//

import Foundation

extension MovieDataEntity {
    
    /// Get `MovieData` Data from `MovieDataEntity`
    /// - Returns: MovieData Created from self
    func getMovieData() -> MovieData {
        return MovieData(
            id: Int(self.id),
            adult: nil,
            backdropPath: nil,
            genres: nil,
            originalLanguage: nil,
            originalTitle: nil,
            overview: self.overview,
            popularity: nil,
            posterPath: self.posterPath,
            releaseDate: self.releaseDate,
            title: self.title,
            video: nil,
            voteAverage: nil,
            voteCount: nil
        )
    }
    
    /// Set `MovieData` Data in `MovieDataEntity`
    /// - Parameter data: MovieData data will used to convert
    func setData(with movieData: MovieData) {
        self.id = Int32(movieData.id)
        self.posterPath = movieData.posterPath
        self.title = movieData.title
        self.overview = movieData.overview ?? ""
        self.releaseDate = movieData.releaseDate ?? ""
    }
}
