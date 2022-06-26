//
//  MoviesListRepository.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 23/06/2022.
//

import RxSwift

final class MoviesListRepository: MoviesListRepositoryProtocol {
    
    private let apiService: APIServiceProtocol
    private let conectivity: ConectivityProtocol
    private let storage: MoviesStorageProtocol
    private let disposeBag: DisposeBag
    
    init(
        apiService: APIServiceProtocol = APIService.shared,
        storage: MoviesStorageProtocol = MoviesListStorageRepository(),
        conectivity: ConectivityProtocol = ConectivityManager(),
        disposeBag: DisposeBag = DisposeBag()
    ) {
        self.apiService = apiService
        self.storage = storage
        self.conectivity = conectivity
        self.disposeBag = disposeBag
    }
    
    func fetchMovies(
        using pageIndex: Int
    ) -> Observable<Result<MoviesResponse, BaseError>> {
        guard conectivity.isConnectedToNetwork() else {
            return fetchFromCache()
        }
        return fetchFromRemoteAndSaveInCache(using: pageIndex)
    }
}

private extension MoviesListRepository {
    
    func fetchFromRemote(
        using pageIndex: Int
    ) -> Observable<Result<MoviesResponse, BaseError>> {
        let request = APIBuilder()
            .setPath(using: .discoverMovies, argument: ["\(pageIndex)"])
            .setMethod(using: .get)
            .build()
        
        return apiService
            .request(
                using: request,
                responseType: MoviesResponse.self
            )
    }
    
    func fetchFromRemoteAndSaveInCache(
        using pageIndex: Int
    ) -> Observable<Result<MoviesResponse, BaseError>>{
        let remoteObserver = fetchFromRemote(using: pageIndex)
        
        remoteObserver.subscribe(onNext: { result in
            if case .success(let response) = result, let movies = response.results {
                self.storage.saveAll(movies)
            }
        })
            .disposed(by: disposeBag)
        
        return remoteObserver
    }
    
    func fetchFromCache() -> Observable<Result<MoviesResponse, BaseError>> {
        let cacheObserver = storage.fetchAll(sortDescriptors: [])
        
        return cacheObserver.map { result in
            guard let movies: [MovieData] = try? result.get() else {
                return .failure(ErrorResolver.shared.getError(for: .exception))
            }
            
            return .success(
                MoviesResponse(
                    results: movies,
                    totalPages: 0
                )
            )
        }
    }
}
