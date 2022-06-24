//
//  MovieDetailsViewModel.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 24/06/2022.
//

import RxSwift
import RxCocoa

final class MovieDetailsViewModel: BaseViewModel {
    
    private let movieDetailsRepository: MovieDetailsRepositoryProtocol
    private let movieID: Int
    private(set) var movieSubject: PublishSubject<MovieData> = PublishSubject()
    
    init(movieDetailsRepository:MovieDetailsRepositoryProtocol = MovieDetailsRepository() , movieID: Int) {
        self.movieID = movieID
        self.movieDetailsRepository = movieDetailsRepository
        super.init()
    }
}

// MARK: - Input Methods

extension MovieDetailsViewModel {
    func fetchMovie() {
        guard stateRelay.value != .loading else { return }
        stateRelay.accept(.loading)
        
        movieDetailsRepository.fetchMovieDetails(using: movieID)
            .subscribe { [weak self] result in
                guard let self = self else { return }
                
                self.stateRelay.accept(.successful)
                
                if case .failure(let error) = result {
                    self.alertItemRelay.accept(.init(message: error.message))
                    return
                }
                
                guard case .success(let movie) = result else { return }
                self.movieSubject.onNext(movie)
            } onError: { [weak self] error in
                guard let self = self , let error = error as? BaseError else { return }
                self.alertItemRelay.accept(.init(message: error.message))
            }
            .disposed(by: disposeBag)
    }
}

