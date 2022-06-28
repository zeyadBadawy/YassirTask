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
    
    /// set empty state of tableView
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 30)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    /// clear empty state of tableView
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
