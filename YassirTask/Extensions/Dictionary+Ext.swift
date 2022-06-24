//
//  Dictionary+Ext.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 23/06/2022.
//

import Foundation

extension Dictionary {
    var json: String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []),
              let jsonString = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return jsonString
    }
    
    var urlSafeBase64EncodedString: String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .withoutEscapingSlashes) else {
            return nil
        }
        return data.base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
}

// MARK: - extension to provide default value to optional string
extension Optional where Wrapped == [String: Any] {
    var value: [String: Any] {
        guard let self = self else {
            return [String: Any]()
        }
        return self
    }
}
