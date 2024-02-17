//
//  Int++String.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import Foundation

extension Int {
    func formatePrice() -> String {
        guard self > 0 else {
            return "$ --"
        }
        return "$ \(self)"
    }
}
