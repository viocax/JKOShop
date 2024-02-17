//
//  ShopItem.swift
//  JKOShop
//
//  Created by drake on 2024/2/17.
//

import Foundation
import protocol Kingfisher.Resource

struct ShopItem {
    var identifier: String = UUID().uuidString
    var name: String
    var description: String
    var price: Int
    var create_Time: TimeInterval
    var picture: String
}

// MARK: Codable
extension ShopItem: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = (try? container.decode(String.self, forKey: .name)) ?? ""
        self.description = (try? container.decode(String.self, forKey: .description)) ?? ""
        self.price = (try? container.decode(Int.self, forKey: .price)) ?? 0
        self.create_Time = (try? container.decode(TimeInterval.self, forKey: .create_Time)) ?? 0
        let picture = (try? container.decode(String.self, forKey: .picture)) ?? ""
        let random = (1...9).map { "\($0 * 100)" }
        self.picture = picture + "/\(random.randomElement()!)/\(random.randomElement()!)"
    }
}

// MARK: ShopItemsViewModel
extension ShopItem: ShopItemsViewModel {
    var title: String {
        return self.name
    }

    var image: Resource {
        return RandomImageInfo(urlString: picture, identifier)
    }
    
    var createTime: Date {
        return Date(timeIntervalSince1970: self.create_Time)
    }
}
