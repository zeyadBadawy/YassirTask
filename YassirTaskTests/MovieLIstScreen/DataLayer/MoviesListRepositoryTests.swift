//
//  MoviesListRepositoryTests.swift
//  YassirTaskTests
//
//  Created by Zeyad Badawy on 26/06/2022.
//

import XCTest
@testable import YassirTask
import RxTest
import RxSwift

class MoviesListRepositoryTests: XCTestCase {
    private var sut: MoviesListRepositoryProtocol!
    private var disboseBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        disboseBag = DisposeBag()
        sut = MoviesListRepository(
            apiService: MockValidApiService(),
            storage: MockValidMoviesStorage(),
            conectivity: MockConnectedConectivity(),
            disposeBag: disboseBag
        )
    }
    
    override func tearDown() {
        sut = nil
        disboseBag = nil
        super.tearDown()
    }
    
    func testFetchingMoviesFromRemoteSuccess() {
        let exp = expectation(description: "Fetching movies from remote")
        
        let mockValidApiService = MockValidApiService()
        mockValidApiService.fileName = "DiscoverMovies"
        
        sut = MoviesListRepository(
            apiService: mockValidApiService,
            storage: MockValidMoviesStorage(),
            conectivity: MockConnectedConectivity(),
            disposeBag: disboseBag
        )
        
        sut.fetchMovies(using: 1)
            .subscribe(onNext: { result in
                
                switch result {
                case .success(let response):
                    XCTAssertFalse(response.results.isNil)
                    exp.fulfill()
                    
                case .failure(let error):
                    XCTAssertNil(error)
                    exp.fulfill()
                }
            })
            .disposed(by: disboseBag)
        
        waitForExpectations(timeout: 1)
    }
    
    func testFetchingMoviesFromRemoteFailure() {
        let exp = expectation(description: "Fetching movies from remote")
        
        let mockInValidApiService = MockInValidApiService()
        
        sut = MoviesListRepository(
            apiService: mockInValidApiService,
            storage: MockValidMoviesStorage(),
            conectivity: MockConnectedConectivity(),
            disposeBag: disboseBag
        )
        
        sut.fetchMovies(using: 1)
            .subscribe(onNext: { result in
                
                switch result {
                case .success(let response):
                    XCTAssertTrue(response.results.isNil)
                    exp.fulfill()
                    
                case .failure(let error):
                    XCTAssertNotNil(error)
                    exp.fulfill()
                }
            })
            .disposed(by: disboseBag)
        
        waitForExpectations(timeout: 1)
    }
    
    func testFetchingMoviesFromCacheSuccess() {
        let exp = expectation(description: "Fetching movies from remote")
        let notConnectedConectivity = MockNotConnectedConectivity()
        
        sut = MoviesListRepository(
            apiService: MockValidApiService(),
            storage: MockValidMoviesStorage(),
            conectivity: notConnectedConectivity,
            disposeBag: disboseBag
        )
        
        sut.fetchMovies(using: 1)
            .subscribe(onNext: { result in
                
                switch result {
                case .success(let response):
                    XCTAssertFalse(response.results.isNil)
                    exp.fulfill()
                    
                case .failure(let error):
                    XCTAssertNil(error)
                    exp.fulfill()
                }
            })
            .disposed(by: disboseBag)
        
        waitForExpectations(timeout: 1)
    }
    
    func testFetchingMoviesFromCacheFailureResponse() {
        let exp = expectation(description: "Fetching movies from remote")
        let invalidStorage = MockInValidMoviesStorage()
        let notConnectedConectivity = MockNotConnectedConectivity()
        
        sut = MoviesListRepository(
            apiService: MockValidApiService(),
            storage: invalidStorage,
            conectivity: notConnectedConectivity,
            disposeBag: disboseBag
        )
        
        sut.fetchMovies(using: 1)
            .subscribe(onNext: { result in
                
                switch result {
                case .success(let response):
                    XCTAssertTrue(response.results.isNil)
                    exp.fulfill()
                    
                case .failure(let error):
                    XCTAssertNotNil(error)
                    exp.fulfill()
                }
            })
            .disposed(by: disboseBag)
        
        waitForExpectations(timeout: 1)
    }
}
