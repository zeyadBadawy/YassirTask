//
//  MovieListViewModel.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 23/06/2022.
//

import RxSwift
import RxCocoa

class MovieListViewModel:BaseViewModel {
    private let moviesListRepository: MoviesListRepositoryProtocol
    private var pageIndex: Int = 1
    private var hasMore = true
    private var movies: [MovieData] = [] {
        didSet {
            moviesSubject.onNext(movies)
        }
    }
    private(set) var moviesSubject: BehaviorSubject<[MovieData]> = .init(value: [])
    
    init(moviesListRepository: MoviesListRepositoryProtocol = MoviesListRepository()) {
        self.moviesListRepository = moviesListRepository
    }
}

// MARK: - Input Methods

extension MovieListViewModel {
    func fetchMovies() {
        guard hasMore else { return }
        guard stateRelay.value != .loading else { return }
        stateRelay.accept(.loading)
        
        moviesListRepository.fetchMovies(using: pageIndex)
            .subscribe { [weak self] result in
                guard let self = self else { return }
                
                self.stateRelay.accept(.successful)
                
                if case .failure(let error) = result {
                    self.alertItemRelay.accept(.init(message: error.message))
                    return
                }
                
                guard case .success(let moviesResponse) = result else { return }
                self.handleOnCompleteFetchingData(using: moviesResponse)
            } onError: { [weak self] error in
                guard let self = self else { return }
                self.handleOnErrorFetchingMovies(error)
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - Private Methods

private extension MovieListViewModel {
    func handleOnCompleteFetchingData(using moviesResponse: MoviesResponse) {
        guard let newMovies: [MovieData] = moviesResponse.results, !newMovies.isEmpty else { return }
        self.movies.append(contentsOf: newMovies)
        guard let totalPages = moviesResponse.totalPages, totalPages > pageIndex else {
            hasMore = false
            return }
        self.hasMore = pageIndex <= totalPages
        pageIndex += 1
    }
    
    func handleOnErrorFetchingMovies(_ error: Error) {
        guard pageIndex == 1 else { return }
        guard let error = error as? BaseError else { return }
        self.alertItemRelay.accept(.init(message: error.message))
    }
}
