//
//  HTTPMethod.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 23/06/2022.
//

import Foundation

/// Enumeration that represents types of Network Methods
enum HTTPMethod: String {
    case connect = "CONNECT"
    case delete = "DELETE"
    case get = "GET"
    case head = "HEAD"
    case options = "OPTIONS"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
    case trace = "TRACE"
}

/// Enumeration that represents types of Network Headers
typealias HTTPHeaders = [String: String]

enum HTTPHeader {
    static let contentType = "Content-Type"
    static let clientID = "client_id"
}

/// Enumeration that represents type of Network Parameters
typealias Parameters = [String: Any]

enum RequestParams {
    case body(_: Parameters)
    case query(_: Parameters)
}

/// Enumeration that represents types of Content-Type Header
enum ContentType {
    static let json = "application/json"
    static let formEncode = "application/x-www-form-urlencoded"
}
