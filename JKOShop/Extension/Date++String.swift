//
//  Date++String.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import Foundation

fileprivate struct DateFomat {
    static let formater = DateFormatter()
    static func getSring(_ date: Date) -> String {
        formater.dateFormat = "yyyy-MM-dd"
        return formater.string(from: date)
    }
}

extension Date {
    func toString() -> String {
        return DateFomat.getSring(self)
    }
}
