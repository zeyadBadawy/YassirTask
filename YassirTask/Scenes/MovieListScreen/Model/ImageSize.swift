//
//  ImageSize.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 23/06/2022.
//

import Foundation

enum ImageSize: String, Decodable {
    case original
    case w300
    case w780
    case w1280
    case w45
    case w92
    case w154
    case w185
    case w500
    case w342
    case h632
}

extension ImageSize {
    // Set default value in case of decoding failure
    init(from decoder: Decoder) throws {
        self = try ImageSize(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .original
    }
}
