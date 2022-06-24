//
//  MovieDetailsRepositoryProtocol.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 24/06/2022.
//

import RxSwift

protocol MovieDetailsRepositoryProtocol {
    func fetchMovieDetails(
        using movieID: Int
    ) -> Observable<Result<MovieData, BaseError>>
}
