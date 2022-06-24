//
//  MoviesListRepository.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 23/06/2022.
//

import RxSwift

final class MoviesListRepository: MoviesListRepositoryProtocol {
    
    private let apiService: APIServiceProtocol
    private let disposeBag: DisposeBag
    
    init(
        apiService: APIServiceProtocol = APIService.shared,
        disposeBag: DisposeBag = DisposeBag()
    ) {
        self.apiService = apiService
        self.disposeBag = disposeBag
    }
    
    func fetchTopRatedMovies(
        using pageIndex: Int
    ) -> Observable<Result<MoviesResponse, BaseError>> {
        return fetchFromRemote(using: pageIndex)
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
}
