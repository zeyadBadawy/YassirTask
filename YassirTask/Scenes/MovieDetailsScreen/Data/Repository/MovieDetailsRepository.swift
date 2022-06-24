//
//  MovieDetailsRepository.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 24/06/2022.
//

import RxSwift

final class MovieDetailsRepository: MovieDetailsRepositoryProtocol {
    
    private let apiService: APIServiceProtocol
    
    //    private let storage: MoviesStorageContract
    
    //    private let reachability: ReachabilityContract
    
    private let disposeBag: DisposeBag
    
    init(
        apiService: APIServiceProtocol = APIService.shared,
        //        storage: MoviesStorageContract = MoviesStorageManager(),
        //        reachability: ReachabilityContract = ReachabilityManager(),
        disposeBag: DisposeBag = DisposeBag()
    ) {
        self.apiService = apiService
        //        self.storage = storage
        //        self.reachability = reachability
        self.disposeBag = disposeBag
    }
    
    func fetchMovieDetails(
        using movieID: Int
    ) -> Observable<Result<MovieData, BaseError>> {
        //        guard reachability.isConnectedToNetwork() else {
        //            return fetchFromCache()
        //        }
        
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
