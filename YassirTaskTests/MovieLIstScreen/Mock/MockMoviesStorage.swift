//
//  MockMoviesStorage.swift
//  YassirTaskTests
//
//  Created by Zeyad Badawy on 26/06/2022.
//

@testable import YassirTask
import RxTest
import RxSwift

final class MockValidMoviesStorage: DisposeObject, MoviesStorageProtocol {
    func fetchAll(sortDescriptors: [NSSortDescriptor]) -> Observable<Result<[MovieData], BaseError>> {
        return  Observable<Result<[MovieData], BaseError>>.just(
            .success(MockData.moviesData)
        )
    }
    
    func saveAll(_ movies: [MovieData]) {}
    
    func save(_ movieData: MovieData) {}
    
    func deleteAll() {}
}

final class MockInValidMoviesStorage: DisposeObject, MoviesStorageProtocol {
    func fetchAll(sortDescriptors: [NSSortDescriptor]) -> Observable<Result<[MovieData], BaseError>> {
        return  Observable<Result<[MovieData], BaseError>>.just(
            .failure(MockData.unexpectedError)
        )
    }
    
    func saveAll(_ movies: [MovieData]) {}
    
    func save(_ movieData: MovieData) {}
    
    func deleteAll() {}
}
