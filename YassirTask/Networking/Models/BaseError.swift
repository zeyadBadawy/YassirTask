//
//  BaseError.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 23/06/2022.
//

import Foundation

struct BaseError: Error {
    let code: Int
    let message: String
}

extension BaseError: Equatable {}
