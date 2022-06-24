//
//  MoviesListRepositoryProtocol.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 23/06/2022.
//

import RxSwift

protocol MoviesListRepositoryProtocol {
    func fetchTopRatedMovies(
        using pageIndex: Int
    ) -> Observable<Result<MoviesResponse, BaseError>>
}
