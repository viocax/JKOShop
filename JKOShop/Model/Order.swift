//
//  Order.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import Foundation

struct Order {
    var identifer: String = UUID().uuidString
    var items: [ShopItem]
    var createTime: TimeInterval
    var price: Int
}

// MARK: Codable
extension Order: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.createTime = (try? container.decode(TimeInterval.self, forKey: .createTime)) ?? 0
        self.items = (try? container.decode([ShopItem].self, forKey: .items)) ?? []
        self.price = (try? container.decode(Int.self, forKey: .price)) ?? 0
    }
}
