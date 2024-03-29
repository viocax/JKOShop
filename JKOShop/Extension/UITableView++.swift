//
//  UITableView++.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import UIKit

extension UITableView {

    @discardableResult
    func registerClass<T: UITableViewCell>(_ type: T.Type) -> UITableView {
        self.register(type.self, forCellReuseIdentifier: String(describing: type.self))
        return self
    }
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T
    }
}
