//
//  MoviesListViewModelTests.swift
//  YassirTaskTests
//
//  Created by Zeyad Badawy on 26/06/2022.
//

import XCTest
@testable import YassirTask
import RxSwift

class MovieListViewModelTests: XCTestCase {
    private var sut: MovieListViewModel!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        sut = MovieListViewModel(moviesListRepository: MockValidMoviesListRepository())
    }
    
    override func tearDown() {
        sut = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func testCallingFetchMovieSuccess() {
        let exp = expectation(description: "Fetching movies description")
        sut = MovieListViewModel(moviesListRepository: MockValidMoviesListRepository())
        
        sut.fetchMovies()
        
        sut.moviesSubject
            .subscribe { movies in
                exp.fulfill()
                XCTAssertFalse(movies.isEmpty)
            } onError: { error in
                XCTAssertNil(error)
                exp.fulfill()
            }
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 1)
    }
    
    func testCallingFetchMovieFailure() {
        let exp = expectation(description: "Fetching movies description")
        sut = MovieListViewModel(moviesListRepository: MockInValidMoviesListRepository())
        
        sut.fetchMovies()
        
        sut.moviesSubject
            .subscribe(onNext: { movies in
                XCTAssertTrue(movies.isEmpty)
                exp.fulfill()
            })
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 10)
    }
}
