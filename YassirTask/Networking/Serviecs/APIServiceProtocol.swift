//
//  APIServiceProtocol.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 23/06/2022.
//

import RxSwift

protocol APIServiceProtocol {
    func request<T: Decodable>(
        using request: URLRequest,
        responseType: T.Type,
        decoder: JSONDecoder,
        retry: Int
    ) -> Observable<Result<T, BaseError>>
}

extension APIServiceProtocol {
    func request<T: Decodable>(
        using request: URLRequest,
        responseType: T.Type = T.self,
        decoder: JSONDecoder = .init(),
        retry: Int = NetworkConstants.retries
    ) -> Observable<Result<T, BaseError>> {
        self.request(
            using: request,
            responseType: responseType,
            decoder: JSONDecoder(),
            retry: NetworkConstants.retries
        )
    }
}
