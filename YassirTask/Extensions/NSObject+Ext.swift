//
//  NSObject+Ext.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 23/06/2022.
//

import Foundation

extension NSObject {
    
    /// Returns the receiver's classname as a string, not including the namespace.
    class var classNameWithoutNamespaces: String {
        return String(describing: self)
    }
}
