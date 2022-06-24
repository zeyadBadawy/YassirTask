//
//  UITableView+Ext.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 23/06/2022.
//

import UIKit

extension UITableView {
    
    func registerCellNib<T: UITableViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
        let nibName = reuseIdentifier ?? T.classNameWithoutNamespaces
        self.register(T.loadNib(), forCellReuseIdentifier: nibName)
    }
    
    /// dequeue cell with generics
    func dequeue<T: UITableViewCell>() -> T {
        guard
            let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T
        else { fatalError("Could not deque cell with type \(T.self)") }
        return cell
    }
}
