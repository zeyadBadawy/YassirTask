//
//  MockMoviesListRepository.swift
//  YassirTaskTests
//
//  Created by Zeyad Badawy on 26/06/2022.
//

@testable import YassirTask
import RxSwift
import RxTest

final class MockValidMoviesListRepository: DisposeObject, MoviesListRepositoryProtocol {
    func fetchMovies(
        using pageIndex: Int
    ) -> Observable<Result<MoviesResponse, BaseError>> {
        
        return  Observable<Result<MoviesResponse, BaseError>>.just(
            .success(MockData.moviesResponse)
        )
    }
}

final class MockInValidMoviesListRepository: DisposeObject, MoviesListRepositoryProtocol {
    func fetchMovies(
        using pageIndex: Int
    ) -> Observable<Result<MoviesResponse, BaseError>> {

        return  Observable<Result<MoviesResponse, BaseError>>.just(
            .failure(MockData.unexpectedError)
        )
    }
}
