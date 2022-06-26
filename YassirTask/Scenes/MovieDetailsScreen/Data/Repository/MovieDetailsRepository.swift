//
//  MovieDetailsRepository.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 24/06/2022.
//

import RxSwift

final class MovieDetailsRepository: MovieDetailsRepositoryProtocol {
    
    private let apiService: APIServiceProtocol
    private let conectivity: ConectivityProtocol
    
    private let disposeBag: DisposeBag
    
    init(
        apiService: APIServiceProtocol = APIService.shared,
        conectivity: ConectivityProtocol = ConectivityManager(),
        disposeBag: DisposeBag = DisposeBag()
    ) {
        self.apiService = apiService
        self.conectivity = conectivity
        self.disposeBag = disposeBag
    }
    
    func fetchMovieDetails(
        using movieID: Int
    ) -> Observable<Result<MovieData, BaseError>> {
        guard conectivity.isConnectedToNetwork() else {
            return Observable.create { observer in
                observer.onNext(.failure(ErrorResolver.shared.getError(for: .connection)))
                return Disposables.create()
            }
        }
        return fetchFromRemote(using: movieID)
    }
}

private extension MovieDetailsRepository {
    
    func fetchFromRemote(
        using movieID: Int
    ) -> Observable<Result<MovieData, BaseError>> {
        let request = APIBuilder()
            .setPath(using: .movieDetails, argument: ["\(movieID)"])
            .setMethod(using: .get)
            .build()
        
        return apiService
            .request(
                using: request,
                responseType: MovieData.self
            )
    }
}
